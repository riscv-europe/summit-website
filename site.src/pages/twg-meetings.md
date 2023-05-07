<img src="media/img/RISC-V-London-2019-09.jpg" width=100%>

## Technical Working Group Meetings

Monday June 5th afternoon will be dedicated to Technical Working Group
(TWG) meetings, organized by:

 - [RISC-V International](https://riscv.org).
 - [OpenHW Group](https://www.openhwgroup.org).

The **preliminary schedule** of the meetings that will meet on Monday
5th is provided below. The **final schedule**, and room numbers
will be published in a few weeks.

Please note that to attend TWG meetings organized by RISC-V
International, a [personal or corporate
membership](https://riscv.org/membership) is required.

<table class="riscv-sb">
<thead>
<tr>
<th>TWG</th>
<th colspan="2">RISC-V International</th>
<th>OpenHW Group</th>
</tr>
<tr>
<th>Room</th>
<th>(TBA)</th>
<th>(TBA)</th>
<th>(TBA)</th>
</tr>
</thead>
<tbody>
<tr>
<tr>
<td>14:00</td>
<td rowspan="2" style="background:var(--riscv-lp);">[Security HC](#security-hc)</td>
<td rowspan="4" style="background:var(--riscv-ly);">Ambassadors<br>Megan Lehn</td>
<td style="background:var(--riscv-lg);">Welcome -- Agenda Review</td>
</tr>
<tr>
<td>14:15</td>
<td rowspan="4" style="background:var(--riscv-lg);">Project Release Process<br>RTL Freeze Checklist</td>
</tr>
<tr>
<td>14:30</td>
<td rowspan="2" style="background:var(--riscv-lp);">[RVM-CSI](#rvm-csi)</td>
<tr>
<td>14:45</td>
</tr>
<tr>
<td>15:00</td>
<td rowspan="2" style="background:var(--riscv-lp);">[Code Size](#code-size)</td>
<td rowspan="2" style="background:var(--riscv-ly);">Data Centrer SIG</td>
</tr>
<tr>
<td>15:15</td>
<td rowspan="3" style="background:var(--riscv-lg);">CVA6</td>
<tr>
<td>15:30</td>
<td rowspan="2" style="background:var(--riscv-lp);">[Cryptographic Extensions TG](#cryptographic-extensions-tg)<br>[Post-Quantum Cryptography](#post-quantum-cryptography)</td>
<td rowspan="2" style="background:var(--riscv-ly);">HPC SIG</td>
</tr>
<td>15:45</td>
<tr>
<td>16:00</td>
<td colspan="3">Break</td>
<tr>
<td>16:15</td>
<td rowspan="2" style="background:var(--riscv-lp);">Architectural Compatibility<br>Test SIG</td>
<td rowspan="2" style="background:var(--riscv-ly);">SoC HC</td>
<td rowspan="2" style="background:var(--riscv-lg);">Verification Task Group</td>
</tr>
<tr>
<td>16:30</td>
<tr>
<td>16:45</td>
<td rowspan="2" style="background:var(--riscv-lp);">Automotive SIG</td>
<td rowspan="2" style="background:var(--riscv-ly);">SSLP-TG</td>
<td rowspan="4" style="background:var(--riscv-lg);">CV32E40Pv2</td>
</tr>
<tr>
<td>17:00</td>
</tr>
<tr>
<td>17:15</td>
<td rowspan="2" style="background:var(--riscv-lp);">Floating-Point SIG</td>
<td rowspan="2" style="background:var(--riscv-ly);">SIG-SOFT-CPU</td>
</tr>
<tr>
<td>17:30</td>
</tr>
<tr>
<td>17:45</td>
<td rowspan="2" style="background:var(--riscv-lp);">ACT Plans and Challenges</td>
<td>Closing</td>
<td rowspan="2" style="background:var(--riscv-lg);">CV-X-IF Project</td>
</tr>
<tr>
<td>18:00</td>
<td rowspan="2">&nbsp;</td>
</tr>
<tr>
<td>18:15</td>
<td>Closing</td>
<td>Closing</td>
</tr>
</tbody>
</table>


## RISC-V International WG Meetings


### Security HC

The main goals of the *Security Horizontal Committee* are:

 - Promote RISC-V as an ideal vehicle for the security community
 - Liaise with other internal RISC V committees and with external
   security committees
 - Create an information repository on new attack trends, threats and
   countermeasures
 - Identify top 10 open challenges in security for the RISC-V
   community to address
 - Propose security committees (Marketing or Technical) to tackle
   specific security topics
 - Recruit security talent to the RISC-V ecosystem (e.g., into
   committees)
 - Develop consensus around best security practices for IoT devices
   and embedded systems

More info at <https://lists.riscv.org/g/security>.


### RVM-CSI

The *RISC-V Common Software Interface (RVM-CSI) Special Interest Group
(SIG)* drives the strategy and coordinates the development of RISC-V’s
Common Software Interface (CSI) for RISC-V Microcontrollers.

More info at <https://lists.riscv.org/g/sig-rvm-csi>.


### Code Size

The *Code Size Reduction TG* will develop a holistic solution to
reducing code size, covering different profiles to be competitive with
other core implementations of other architectures of a similar class.

Priority is given to small embedded cores which often have very
constrained memory sizes and so code size reduction is most important
for cost reduction. Larger/higher performance cores will also benefit
from reduced code size.

More info at <https://lists.riscv.org/g/tech-code-size>.


### Cryptographic Extensions TG

The *Cryptographic Extensions Task Group* will propose ISA extensions
to the vector extensions for the standardized and secure execution of
popular cryptography algorithms.  To ensure that processor
implementers are able to support a wide range of performance and
security levels the committee will create a base and an extended
specification. The base will be comprised of low-cost instructions
that are useful for the acceleration of common algorithms. The
extended specification will include greater functionality, reserve
encodings for more algorithms, and will facilitate improved security
of execution and higher performance.  The scope will include symmetric
and asymmetric cryptographic algorithms and related primitives such as
message digests.

The committee will also make ISA extension proposals for lightweight
scalar instructions for 32 and 64 bit machines that improve the
performance and reduce the code size required for software execution
of common algorithms like AES and SHA and lightweight algorithms like
PRESENT and GOST, as well as ISA proposals regarding the use of random
bits and secure key management.

More info at <https://wiki.riscv.org/display/HOME/Cryptographic+Extensions+TG>.

### Post-Quantum Cryptography

The *Post-Quantum Cryptography* explore and recommend RISC-V
Instruction Set Architecture (ISA) Extensions that enhance performance
and implementation efficiency for contemporary public-key
cryptography, with a focus on standard Post-Quantum Cryptography
algorithms like Kyber, Dilithium, and others.

More info at <https://lists.riscv.org/g/tech-pqc-cryptography>.
