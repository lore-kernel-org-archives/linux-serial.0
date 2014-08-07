From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 1/2] tty: serial: 8250: Add Mediatek UART driver
Date: Thu, 7 Aug 2014 16:07:41 +0200
Message-ID: <CABuKBeKJ=KFc1DfvyHgD+iAC1=yLqYjjDUc0CH+1zbRQzw_DJw@mail.gmail.com>
References: <1407394292-26317-1-git-send-email-matthias.bgg@gmail.com>
	<1407394292-26317-2-git-send-email-matthias.bgg@gmail.com>
	<1407417714.8334.8.camel@acox1-desk.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1407417714.8334.8.camel@acox1-desk.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.cz, Grant Likely <grant.likely@linaro.org>, Varka Bhadram <varkabhadram@gmail.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Yingjoe Chen <yingjoe.chen@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

2014-08-07 15:21 GMT+02:00 Alan Cox <alan@linux.intel.com>:
>
>> +      * Some baudrates are not supported by the chip, so we use the next
>> +      * lower rate supported and update termios c_flag.
>
> I don't see the termios updating being done now ?

Please have a look on the usage of the SET_CFLAG_BAUD macro in the patch.
I'm not sure if it is the way to go though.

>
>> +     data->clk = of_clk_get(np, 0);
>> +     if (IS_ERR(data->clk)) {
>> +             pr_warn("Can't get timer clock");
>> +             return PTR_ERR(data->clk);
>> +     }
>> +
>> +     err = clk_prepare_enable(data->clk);
>> +     if (err) {
>> +             pr_warn("Can't prepare clock");
>
> and these do need a newline on them. They are also not very useful as
> they don't indicate what device was involved. If you passed pdev from
> mtk8250_probe you'd be able to use dev_warn instead
>
> Otherwise looks great and exactly as 8250_core is intended to be used.
>
> Alan
>
>



-- 
motzblog.wordpress.com
