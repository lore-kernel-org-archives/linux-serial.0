From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2 1/2] tty: serial: 8250: Add Mediatek UART driver
Date: Thu, 7 Aug 2014 19:35:12 +0100
Message-ID: <20140807193512.1825b291@alan.etchedpixels.co.uk>
References: <1407394292-26317-1-git-send-email-matthias.bgg@gmail.com>
	<1407394292-26317-2-git-send-email-matthias.bgg@gmail.com>
	<1407417714.8334.8.camel@acox1-desk.ger.corp.intel.com>
	<CABuKBeKJ=KFc1DfvyHgD+iAC1=yLqYjjDUc0CH+1zbRQzw_DJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CABuKBeKJ=KFc1DfvyHgD+iAC1=yLqYjjDUc0CH+1zbRQzw_DJw@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.cz, Grant Likely <grant.likely@linaro.org>, Varka Bhadram <varkabhadram@gmail.com>, Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>, Yingjoe Chen <yingjoe.chen@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, 7 Aug 2014 16:07:41 +0200
Matthias Brugger <matthias.bgg@gmail.com> wrote:

> 2014-08-07 15:21 GMT+02:00 Alan Cox <alan@linux.intel.com>:
> >
> >> +      * Some baudrates are not supported by the chip, so we use the next
> >> +      * lower rate supported and update termios c_flag.
> >
> > I don't see the termios updating being done now ?
> 
> Please have a look on the usage of the SET_CFLAG_BAUD macro in the patch.
> I'm not sure if it is the way to go though.

Ah missed that - no it's not the right way to go. From
8250_core:serial8250_do_set_termios() do

        /* Don't rewrite B0 */
        if (tty_termios_baud_rate(termios))
                tty_termios_encode_baud_rate(termios, baud, baud);


which will encoding the baud rate correctly for all cases, and where
possible encode it in the old style format rather than using BOTHER
(which old old apps cannot handle)

Alan
