From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] sh-sci: add R8A7743/5 support
Date: Fri, 30 Sep 2016 18:06:25 +0300
Message-ID: <de1717e2-d54b-d3a3-4a7c-4a501d7ccd3b@cogentembedded.com>
References: <2017044.9fZNuWa2OZ@wasted.cogentembedded.com>
 <CAMuHMdWEg8V81w=MT4akCaV=VUGopyWLJtSQC+KeWSpTR5dR_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWEg8V81w=MT4akCaV=VUGopyWLJtSQC+KeWSpTR5dR_w@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 09/30/2016 11:38 AM, Geert Uytterhoeven wrote:

>> Renesas  RZ/G SoC also have the SCIF, SCIFA, SCIFB, and HSCIF ports.
>> Document RZ/G1[ME] (also known as R8A774[35]) SoC bindings along with
>> the RZ/G family bindings.  The driver itself also needs to recognize
>> the latter binding for the SCIF ports, so teach it...
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[...]

>> ===================================================================
>> --- tty.orig/drivers/tty/serial/sh-sci.c
>> +++ tty/drivers/tty/serial/sh-sci.c
>> @@ -2950,6 +2950,9 @@ static const struct of_device_id of_sci_
>>         }, {
>>                 .compatible = "renesas,rcar-gen3-scif",
>>                 .data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
>> +       }, {
>> +               .compatible = "renesas,rzg-scif",
>> +               .data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
>>         },
>>         /* Generic types */
>>         {
>
> However, I wouldn't bother adding RZ/G family-specific DT bindings, as
> RZ/G is a derivative of R-Car Gen2.

    Then we shouldn't have added gen2/3 bindings too since they resolve to the 
same register mapping as gen1. :-)

> Gr{oetje,eeting}s,
>
>                         Geert

MBR, Sergei
