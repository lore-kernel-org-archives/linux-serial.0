From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 1/5] serial: sh-sci: Update DT binding documentation
 for GPIO modem lines
Date: Fri, 18 Mar 2016 16:18:54 +0100
Message-ID: <CAMuHMdUM=budxsERr7MhvJCJ=wgSsWBiPiqwrnBrONrCq9XKxg@mail.gmail.com>
References: <1458222449-12324-1-git-send-email-geert+renesas@glider.be>
	<1458222449-12324-2-git-send-email-geert+renesas@glider.be>
	<20160317224336.GD23806@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160317224336.GD23806@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Simon,

On Thu, Mar 17, 2016 at 11:43 PM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Mar 17, 2016 at 02:47:25PM +0100, Geert Uytterhoeven wrote:
>> Amend the DT bindings for the Renesas SCI driver to allow describing
>> optional GPIO-controlled modem lines, which can be used where dedicated
>> modem lines are not available.
>>
>> The property naming is dictated by the SERIAL_MCTRL_GPIO helpers.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: devicetree@vger.kernel.org
>> ---
>>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>> index 528c3b90f23cb04b..f8d7b36742967163 100644
>> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>> @@ -76,6 +76,9 @@ Optional properties:
>>    - dmas: Must contain a list of two references to DMA specifiers, one for
>>         transmission, and one for reception.
>>    - dma-names: Must contain a list of two DMA names, "tx" and "rx".
>> +  - {cts,dsr,dcd,rng,rts,dtr,out1,out2}-gpios: Must contain a GPIO specifier,
>> +    referring to the GPIO pin to be used as the UART's CTS, DSR, DCD, RNG, RTS,
>> +    DTR, OUT1, or OUT2 line.
>>
>>  Example:
>>       aliases {
>
> Hi Geert,
>
> I do not feel strongly about this but I wonder if it
> would make sense to update the example with the new properties.

These are meant to be added to the board .dts file, not to the .dtsi files.
I can add an example if you like, let's hope nobody copies it blindly to a
.dtsi file...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
