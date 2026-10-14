# Evidencias — LTE/E-UTRAN y EPC en Packet Tracer

## 1. Alcance de las pruebas

Las verificaciones demuestran conectividad IP extremo a extremo en el modelo conceptual. No prueban señalización LTE real, attach EPS, creación de portadores ni túneles GTP.

## 2. Topología validada

La captura final incluye:

- Dos usuarios: UE-01 y UE-02.
- Dos estaciones base conceptuales: eNodeB-01 y eNodeB-02.
- Acceso E-UTRAN representado por LTE-ACCESS-PT y SW-EUTRAN.
- Núcleo EPC con MME, HSS-LTE, PCRF, S-GW y P-GW.
- Red externa con SW-PDN, PDN-INTERNET y WEB-PDN.
- Separación visual entre S1-MME y S1-U.

![Topología LTE completa](../images/topologia-lte-completa.png)

## 3. Pruebas desde UE-01

| Destino | Función | Resultado observado |
|---|---|---|
| `172.16.4.1` | Puerta de enlace del acceso | 4/4 respuestas, 0 % de pérdida |
| `10.4.10.1` | Entrada del transporte S1 | 3/4 inicialmente; respuestas posteriores correctas |
| `10.4.20.10` | Elemento del núcleo de control | 1/4 en la primera ejecución y 4/4 en la segunda |
| `10.4.50.1` | Puerta de enlace SGi/PDN | 4/4 respuestas |
| `10.4.50.10` | Servidor WEB-PDN | 3/4 inicialmente; conectividad estabilizada |

Las pérdidas de los primeros intentos son compatibles con la resolución ARP y la convergencia inicial del escenario. Al repetir las pruebas, la comunicación se estabilizó.

## 4. Trazado hacia WEB-PDN

El comando `tracert 10.4.50.10` llegó al destino en el cuarto salto:

| Salto | Respuesta |
|---|---|
| 1 | `172.16.4.1` |
| 2 | Sin respuesta ICMP |
| 3 | Sin respuesta ICMP |
| 4 | `10.4.50.10` |

Los asteriscos intermedios no implican necesariamente una falla. En el modelo, los dispositivos reenviaron el tráfico pero no respondieron a las sondas ICMP de tiempo excedido usadas por `tracert`.

## 5. Pruebas desde UE-02

| Destino | Resultado observado |
|---|---|
| `172.16.4.1` | 4/4 respuestas, 0 % de pérdida |
| `10.4.50.10` | 4/4 respuestas, 0 % de pérdida |

El segundo usuario también alcanzó el servicio externo a través del recorrido conceptual E-UTRAN–EPC–PDN.

## 6. Servicio HTTP

Desde los equipos de usuario se abrió el portal alojado en:

`http://10.4.50.10`

La carga de la página confirma conectividad de aplicación entre el UE simulado y WEB-PDN, además de la conectividad ICMP verificada con `ping`.

## 7. Movilidad conceptual

Se desplazaron UE-01 y UE-02 entre las áreas de cobertura representadas. Las vistas física y lógica mostraron el cambio de asociación y la continuidad del acceso.

Esta prueba debe interpretarse como una demostración visual. Packet Tracer no ejecuta mediciones radio, selección de celda, mensajes RRC ni un handover X2/S1 real.

## 8. Interpretación técnica

Las pruebas validan:

- Direccionamiento coherente entre los segmentos.
- Encaminamiento extremo a extremo.
- Acceso simultáneo de dos usuarios.
- Disponibilidad de un servicio externo HTTP.
- Continuidad lógica después del movimiento de los terminales.

Las pruebas no validan:

- Autenticación EPS-AKA.
- Registro LTE/NAS.
- Señalización S1AP o Diameter.
- Creación de portadores EPS.
- Encapsulación GTP-C/GTP-U.
- Aplicación real de políticas PCC/QoS.
- Handover LTE real.

## 9. Conclusión

El laboratorio cumple su objetivo como mapa funcional y visual de LTE/EPC. La conectividad observada demuestra que la aproximación IP funciona; la siguiente etapa con Open5GS y srsRAN permitirá estudiar procedimientos y protocolos móviles reales dentro de las posibilidades de una emulación sin radiofrecuencia.
