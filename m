From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: add documentation for the
 SiFive UART driver
Date: Tue, 23 Oct 2018 10:05:40 -0700
Message-ID: <6571bb0e-b36a-1196-4d90-8aa62d8a2a90@sifive.com>
References: <20181019184827.12351-1-paul.walmsley@sifive.com>
 <20181019184827.12351-2-paul.walmsley@sifive.com>
 <CAL_JsqJBSqaxnETdJg1Mdp+H2ay+WKT0JaxLe6D4Fwo_99qUkw@mail.gmail.com>
 <4317548d-f831-29ba-3be9-35f080587db9@sifive.com>
 <CAL_JsqLagTgjDhZ02X=wPFDB4WF2bR7=LyzSW9D=ooo_XB_zOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLagTgjDhZ02X=wPFDB4WF2bR7=LyzSW9D=ooo_XB_zOg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@sifive.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-serial@vger.kernel.org


On 10/20/18 7:21 AM, Rob Herring wrote:
> On Fri, Oct 19, 2018 at 5:06 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>> On 10/19/18 1:45 PM, Rob Herring wrote:
>>> On Fri, Oct 19, 2018 at 1:48 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>>>> Add DT binding documentation for the Linux driver for the SiFive
>>>> asynchronous serial IP block.  Nothing too exotic.
>>>>
>>>> Cc: linux-serial@vger.kernel.org
>>>> Cc: devicetree@vger.kernel.org
>>>> Cc: linux-riscv@lists.infradead.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: Palmer Dabbelt <palmer@sifive.com>
>>>> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>>>> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
>>>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>>>> ---
>>>>    .../bindings/serial/sifive-serial.txt         | 21 +++++++++++++++++++
>>>>    1 file changed, 21 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
>>>> new file mode 100644
>>>> index 000000000000..8982338512f5
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/serial/sifive-serial.txt
>>>> @@ -0,0 +1,21 @@
>>>> +SiFive asynchronous serial interface (UART)
>>>> +
>>>> +Required properties:
>>>> +
>>>> +- compatible: should be "sifive,fu540-c000-uart0" or "sifive,uart0"
>>>>
>>> As I mentioned for the
>>> intc and now the pwm block bindings, if you are going to do version
>>> numbers please document the versioning scheme.
>>>
>>>
>>> Will add that to the binding document.
> I don't seem to be making my point clear. I don't want any of this
> added to a binding doc for particular IP blocks. Write a common doc
> that explains the scheme and addresses the questions I asked. Then
> just reference that doc here.
>
> Maybe this is documented somewhere already? Otherwise, if one is
> creating a new IP block, how do they know what the versioning scheme
> is or what goes in the DT ROM?


Seems like there might be some confusion between IP blocks as integrated 
on an SoC vs. IP blocks in isolation.  It's not necessarily the SoC 
integrator that sets an IP block version number; this can come from the 
IP block vendor itself.  So each IP block may have its own version 
numbering practices for the IP block alone.


For SiFive IP blocks, we at SiFive could probably align on a common 
version numbering structure for what's in the sifive-blocks repository.

But other IP blocks from other vendors may not align to that, or may not 
have version numbers exposed at all.  In those cases there's no way for 
software folks to find out what they are,  as you pointed out earlier.  
This is the case with most DT compatible strings in the kernel tree.

For example, we've integrated the NVDLA IP block, from NVIDIA, on some 
designs.  Any NVIDIA version numbers in that IP block will probably not 
follow the SiFive version numbering scheme.  I'd propose the right thing 
to do for an IP block compatible string is to follow the vendor's 
practice, and then use the SoC integrator's version numbering practice 
for the SoC-integrated compatible string.


In effect, an SoC integration DT compatible string like 
"sifive,fu540-c000-uart" implicitly states an IP block version number: 
"whatever came out of the fab on the chip"[**].   I'd propose that even 
in these cases, there's an advantage to keeping the "0" on the end, 
since it uniquely identifies an SoC-independent IP block, rather than 
just the type of the IP block.   But if the "0" on the end of the SoC 
integration DT compatible string is problematic for you, we can 
certainly drop that last 0 from the SoC integration DT compatible 
string, and only suffer a slight lack of clarity as to what version was 
integrated on that chip.


But for IP block-specific version strings like "sifive,uart0", I think 
we can address your concern, at least for these public IP blocks. Since 
the SiFive UART and some other peripheral IP blocks are open-source, the 
public can have a pretty good idea of what DT version number corresponds 
to the source RTL, since the RTL is public.   The version number 
identifies a specific programming model, without tying that programming 
model to any SoC-specific workarounds, etc.  So for these cases, I think 
there's a pretty good case for having IP block-specific version numbers 
in DT compatible strings, and I hope you'll agree.


The advantage for all of us is that there's then no need to embed 
chip-specific DT match strings in these drivers, for the most part.  We 
just match on "sifive,uart0" and that's it, assuming no chip-specific 
workarounds are needed.


>>>    Where does the
>>> number come from?
>>
>> It comes from the RTL, which is public:
>>
>> https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/uart/UART.scala#L43
> I'm not going to go read your RTL, sorry.


There's no need, but you did ask where it came from.  Sorry you didn't 
like the answer.


Please let us know what you want us to do.


Thanks for your review


- Paul


** The caveat is that even with SoC identifiers in the Linux DT 
compatible strings, there's not enough information in many of the 
existing kernel DT compatibility strings to uniquely identify chip 
versions.  Taking OMAP and Tegra as examples, there are several 
different chip versions for a given SoC generation that came out of the 
fab.    OMAP chip version strings usually began with "ES"; Tegra version 
numbers, as I recall, were a letter and two numbers.  For the most part, 
those versions were never specifically identified in the upstream kernel 
DT strings or in DT file names. (There are some exceptions with OMAP 
where we did identify specific chip version numbers, because sizable 
numbers of folks had boards with early silicon, and we were committed to 
supporting them at the time.)    Sadly even adding these additional chip 
version identifiers to the DT strings wouldn't be perfect: I've seen at 
least one large vendor implementing metal-only ECOs without incrementing 
public chip version numbers. The point here is that we're already not 
uniquely identifying IP blocks with our current Linux DT compatibility 
string scheme.
