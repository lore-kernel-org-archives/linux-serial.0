From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH v5 1/2] tty: serial: 8250: Add Mediatek UART driver
Date: Tue, 09 Sep 2014 22:53:51 +0100
Message-ID: <1410299631.2218.43.camel@acox1-desk.ger.corp.intel.com>
References: <1410276703-5274-1-git-send-email-matthias.bgg@gmail.com>
	 <1410276703-5274-2-git-send-email-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410276703-5274-2-git-send-email-matthias.bgg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, varkabhadram@gmail.com, tklauser@distanz.ch, heiko@sntech.de, yingjoe.chen@gmail.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2014-09-09 at 17:31 +0200, Matthias Brugger wrote:
> The device has a highspeed register which influences the calcualtion
> of the divisor. The chip lacks support for some baudrates. When requested,
> we set the divisor to the next smaller baudrate and adjust the c_cflag
> accordingly.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: Alan Cox <alan@linux.intel.com>

I'm happy with this version
