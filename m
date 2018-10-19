From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: add documentation for the
 SiFive UART driver
Date: Fri, 19 Oct 2018 15:05:11 -0700
Message-ID: <4317548d-f831-29ba-3be9-35f080587db9@sifive.com>
References: <20181019184827.12351-1-paul.walmsley@sifive.com>
 <20181019184827.12351-2-paul.walmsley@sifive.com>
 <CAL_JsqJBSqaxnETdJg1Mdp+H2ay+WKT0JaxLe6D4Fwo_99qUkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJBSqaxnETdJg1Mdp+H2ay+WKT0JaxLe6D4Fwo_99qUkw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@sifive.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-serial@vger.kernel.org


On 10/19/18 1:45 PM, Rob Herring wrote:
> On Fri, Oct 19, 2018 at 1:48 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>> Add DT binding documentation for the Linux driver for the SiFive
>> asynchronous serial IP block.  Nothing too exotic.
>>
>> Cc: linux-serial@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-riscv@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Palmer Dabbelt <palmer@sifive.com>
>> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>> ---
>>   .../bindings/serial/sifive-serial.txt         | 21 +++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
>>
>> diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
>> new file mode 100644
>> index 000000000000..8982338512f5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/serial/sifive-serial.txt
>> @@ -0,0 +1,21 @@
>> +SiFive asynchronous serial interface (UART)
>> +
>> +Required properties:
>> +
>> +- compatible: should be "sifive,fu540-c000-uart0" or "sifive,uart0"
> I assume once again, the last '0' is a version?


Yes.


> Palmer mentioned the
> compatible string is part of the IP block repository?


It is, but there's no guarantee that the compatible string from the RTL 
will make it into a ROM for any given chip.  For example, a customer may 
want the UART, but not want to take the DT ROM to keep area down.


This is one of the reasons why we'll likely switch to the usual 
software-maintained DTS files for Linux, just like the rest of arch/arm, 
arch/powerpc, etc.


> As I mentioned for the
> intc and now the pwm block bindings, if you are going to do version
> numbers please document the versioning scheme.


Will add that to the binding document.


>   Where does the
> number come from?


It comes from the RTL, which is public:

https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/uart/UART.scala#L43



> What's the next version?


1 (or something larger)


> Major vs. minor versions?


Not currently for this IP block.


> ECO fixes?


ECOs for a specific chip?  If so, whether an integrator changes the 
version number in a ROM (if present) is up to whomever does the ECO.  
That may not be SiFive.


Suppose that someone ECOs a SiFive UART in a way that incompatibly 
changes the programming model.  They can choose to submit corresponding 
RTL changes back upstream to the sifive-blocks repository, or not.


If they don't, and they want upstream Linux support, it's up to the 
integrator to define a "foobar,foochip-uart" in their chip DT file, and 
post it upstream to the kernel lists, along with the corresponding 
driver patches.


If however, they do get their changes accepted into the sifive-blocks 
public RTL repository, then the maintainer of sifive-blocks is 
responsible for ensuring that the compatible string in the RTL is 
changed in an appropriate way.


>   Is the version s/w readable?


Not in the UART IP block itself.   In the specific case of the FU540 
chip, there's a string in a ROM.


> How do you ensure it gets
> updated?


The string in the ROM?  For an IP block like the UART, it's up to the 
engineer patching the UART RTL to update the compatible string when the 
programming model changes, and the sifive-blocks maintainer to enforce it.

For a given chip, it's up to the integrator/end user whether they want 
to include the DT ROM or not, and if it's present, it's up to them what 
it contains.


> All that should be addressed.
>
> Otherwise, don't do version numbers because we have no visibility to
> what they mean.


It's all in the public RTL:

https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/uart/UART.scala#L43


>> +- reg: address and length of the register space
>> +- interrupt-parent: should contain a phandle pointing to the SoC interrupt
>> +    controller device node that the UART interrupts are connected to
> Don't need to document interrupt-parent here.


OK, will drop it.


- Paul
