From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCHv2 3/3] tty/serial: at91: fix hardware handshake on SAM9x5
 (without GPIOs)
Date: Wed, 14 Sep 2016 12:31:43 +0200
Message-ID: <CACQ1gAiDzgzB4EbKqPJi66TG0848kJR5TmyCUAehkz_81bVNQA@mail.gmail.com>
References: <20160912094733.21501-1-richard.genoud@gmail.com>
 <20160912094733.21501-4-richard.genoud@gmail.com> <20160912095317.74e5xiedrq5nh3v4@piout.net>
 <CACQ1gAhNdPgtkpt1QPaiKjKi5oaq5vHbt4kKL5tQfwLvDBDo0w@mail.gmail.com> <20160913134556.wpodujgk6yn7rfxz@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160913134556.wpodujgk6yn7rfxz@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Cyrille Pitchen <cyrille.pitchen@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

2016-09-13 15:45 GMT+02:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> On 12/09/2016 at 12:50:38 +0200, Richard Genoud wrote :
>> >> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
>> >> index e9b4fbf88c2d..32154e7231ce 100644
>> >> --- a/drivers/tty/serial/atmel_serial.c
>> >> +++ b/drivers/tty/serial/atmel_serial.c
>> >> @@ -2130,15 +2130,19 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>> >>       } else if ((termios->c_cflag & CRTSCTS) &&
>> >>                  !mctrl_gpio_use_rtscts(atmel_port->gpios)) {
>> >>               /*
>> >> -              * RS232 with hardware handshake (RTS/CTS)
>> >> -              * handled by the controller.
>> >> +              * Automatic hardware handshake (RTS/CTS) only work with
>> >> +              * FIFOs or PDC.
>> >> +              * Meaning that on SAM9x5 the controller can't handle
>> >> +              * the hardware handshake (no FIFOs nor PDC on these platforms).
>> >>                */
>> >> -             if (atmel_use_dma_rx(port) && !atmel_use_fifo(port)) {
>> >> -                     dev_info(port->dev, "not enabling hardware flow control because DMA is used");
>> >> -                     termios->c_cflag &= ~CRTSCTS;
>> >> -             } else {
>> >> +             if (atmel_use_pdc_rx(port) || atmel_use_fifo(port))
>> >>                       mode |= ATMEL_US_USMODE_HWHS;
>> >> -             }
>> >> +             else
>> >> +                     /*
>> >> +                      * The hardware handshake won't be handle by the
>> >> +                      * controller but by the driver.
>> >> +                      */
>> >> +                     mode |= ATMEL_US_USMODE_NORMAL;
>> >
>> > You still need the case where HWHS is impossible and there are no gpio
>> > configured. You need to inform userspace that the configuration was not
>> > applied instead of silently ignoring the error.
>>
>> Could you explain which case it is ?
>> The only one I can see is when there's no GPIO declared for RTS/CTS
>> AND, there's no pin muxed for RTS/CTS either.
>>
>> Have you got another example in mind ?
>>
>
> Hum, actually, it is that case. The other one (CRTSCTS and gpios) is
> handled in the else below. I think you need to keep the termios->c_cflag
> &= ~CRTSCTS; here so that userspace knows configuring it failed.

So, could you explain how you intend to detect that there's no pin
muxed for RTS/CTS ?
Because IHMO, that's not possible with what is described in the DTS.
To be sure that we really understand each other, I want you to tell me
how you intend to make the difference between:
pinctrl-0 = <&pinctrl_usart1 &pinctrl_usart1_rts_cts>;
AND
pinctrl-0 = <&pinctrl_usart1>;
in the atmel_serial driver ?

and then  your test would be:
if (rts_cts_not_muxed()) {
dev_info(port->dev, "hey ! there's no pin muxed for RTS/CTS, I won't
enable HWHS");
}


Meanwhile, I did quite some testing with a sama5d3 xplained I have.
Same results as the SAM9x5. (Unfortunately, I don't have a sama5d2,
the only ones with fifos).

Here are those results:
With RTS/CTS NOT handled by GPIOs (pinctrl-0 = <&pinctrl_usart1
&pinctrl_usart1_rts_cts>;) :
 - if USMODE==HW : Fails in every case. (DMA/PDC/PIO)
 - if USMODE==NORMAL + PDC : crask kernel (quite normal since there's no PDC)
 - if USMODE==NORMAL + DMA : works great, CTS and RTS respond OK
 - if USMODE==NORMAL + PIO : works fine, but some chars gets eaten.

With RTS/CTS handled by GPIOs
(pinctrl-0 = <&pinctrl_usart1;rts-gpios = <&pioB 27
GPIO_ACTIVE_LOW>;cts-gpios = <&pioB 26 GPIO_ACTIVE_LOW>;) :
 - if USMODE==HW : Nonsense
 - if USMODE==NORMAL + PDC : crask kernel (quite normal since there's no PDC)
 - if USMODE==NORMAL + DMA : works great, CTS and RTS respond OK
 - if USMODE==NORMAL + PIO : works fine, but some chars gets eaten.

So, again, commit 5be605ac9af9 is wrong because we don't want to
remove the CRTSCTS flag if rts_cts are muxed !!!

If someone does some testing on a sama5d2, it would help, but from the
informations I have, I stick to this logic:
                /*
                 * Automatic hardware handshake (RTS/CTS) only work with
                 * FIFOs or PDC.
                 * Meaning that on SAM9x5 the controller can't handle
                 * the hardware handshake (no FIFOs nor PDC on these platforms).
                 */
                if (atmel_use_pdc_rx(port) || atmel_use_fifo(port))
                        mode |= ATMEL_US_USMODE_HWHS;
                else
                        /*
                         * The hardware handshake won't be handle by the
                         * controller but by the driver.
                         */
                        mode |= ATMEL_US_USMODE_NORMAL;



Test configuration on 3xplained :

DTS:
            usart1: serial@f0020000 {
                compatible = "atmel,at91sam9260-usart";
                reg = <0xf0020000 0x100>;
                interrupts = <13 IRQ_TYPE_LEVEL_HIGH 5>;
atmel,use-dma-rx; // comment to switch to PIO
dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(5)>, <&dma0 2
(AT91_DMA_CFG_PER_ID(6) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
                dma-names = "tx", "rx";
                pinctrl-names = "default";

                clocks = <&usart1_clk>;
                clock-names = "usart";
pinctrl-0 = <&pinctrl_usart1 &pinctrl_usart1_rts_cts>;
/*
//or
rts-gpios = <&pioB 27 GPIO_ACTIVE_LOW>;
cts-gpios = <&pioB 26 GPIO_ACTIVE_LOW>;
pinctrl-0 = <&pinctrl_usart1>;
*/
                status = "okay";
            };

            usart2: serial@f8020000 {
                compatible = "atmel,at91sam9260-usart";
                reg = <0xf8020000 0x100>;
                interrupts = <14 IRQ_TYPE_LEVEL_HIGH 5>;
atmel,use-dma-rx;
dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(7)>, <&dma1 2
(AT91_DMA_CFG_PER_ID(8) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
rts-gpios = <&pioA 20 GPIO_ACTIVE_LOW>;
cts-gpios = <&pioA 21 GPIO_ACTIVE_LOW>;
                dma-names = "tx", "rx";
                pinctrl-names = "default";
                pinctrl-0 = <&pinctrl_usart2>;
                clocks = <&usart2_clk>;
                clock-names = "usart";
                status = "okay";
            };


On board:

stty -F /dev/ttyS2 115200 raw -echo crtscts -opost clocal cread
stty -F /dev/ttyS3 115200 raw -echo crtscts -opost clocal cread

On one terminal :
cat MAINTAINERS > /dev/ttyS3

On another:
exec 4</dev/ttyS2
cat <&4 >> /tmp/rcv  # ctrl-c and again several times
exec 4<&-
diff -u MAINTAINERS /tmp/rcv
