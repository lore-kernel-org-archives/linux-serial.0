From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Subject: Re: [PATCH v3] serial: Add Milbeaut serial control
Date: Wed, 8 May 2019 21:22:05 +0900
Message-ID: <93002681-37f8-cb12-725c-48c1695d29a0@socionext.com>
References: <1555555916-22251-1-git-send-email-sugaya.taichi@socionext.com>
 <20190426191515.757e6015@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190426191515.757e6015@alans-desktop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, Takao Orito <orito.takao@socionext.com>, Kazuhiro Kasai <kasai.kazuhiro@socionext.com>, Shinji Kanematsu <kanematsu.shinji@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

Thank you for pointing out.

On 2019/04/27 3:15, Alan Cox wrote:
> O
>> +static void mlb_usio_set_termios(struct uart_port *port,
>> +			struct ktermios *termios, struct ktermios *old)
>> +{
>> +	unsigned int escr, smr = MLB_USIO_SMR_SOE;
>> +	unsigned long flags, baud, quot;
>> +
>> +	switch (termios->c_cflag & CSIZE) {
>> +	case CS5:
>> +		escr = MLB_USIO_ESCR_L_5BIT;
>> +		break;
>> +	case CS6:
>> +		escr = MLB_USIO_ESCR_L_6BIT;
>> +		break;
>> +	case CS7:
>> +		escr = MLB_USIO_ESCR_L_7BIT;
>> +		break;
>> +	case CS8:
>> +	default:
>> +		escr = MLB_USIO_ESCR_L_8BIT;
>> +		break;
>> +	}
>> +
>> +	if (termios->c_cflag & CSTOPB)
>> +		smr |= MLB_USIO_SMR_SBL;
>> +
>> +	if (termios->c_cflag & PARENB) {
>> +		escr |= MLB_USIO_ESCR_PEN;
>> +		if (termios->c_cflag & PARODD)
>> +			escr |= MLB_USIO_ESCR_P;
>> +	}
> 
> If you don't suport CMSPAR then clear that bit in termios as well
> 

OK, clear the bit because of not supported.

>> +	/* Set hard flow control */
>> +	if (of_property_read_bool(port->dev->of_node, "auto-flow-control") ||
>> +			(termios->c_cflag & CRTSCTS))
>> +		escr |= MLB_USIO_ESCR_FLWEN;
> 
> That's just broken. The termios bits are the definitive things for the
> port, and in addition even if they are forced you need to correct the
> termios data.
> 
> You might want to control flow control *at boot* with an OF property but
> doing it post boot is just busted.
> 

Ah, Yes.
I think OF property should not be here, and it may only be used to determine
the characteristics of the port.
I try to make a fixes patch.

Thanks,
Sugaya Taichi


> Alan
> 
