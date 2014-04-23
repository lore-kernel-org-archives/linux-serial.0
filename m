From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: uart: add hw flow control support configuration
Date: Wed, 23 Apr 2014 15:27:17 +0100
Message-ID: <20140423152717.7100f604@alan.etchedpixels.co.uk>
References: <1397243877-23234-1-git-send-email-m-karicheri2@ti.com>
	<3E54258959B69E4282D79E01AB1F32B70471B198@DFLE11.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <3E54258959B69E4282D79E01AB1F32B70471B198@DFLE11.ent.ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

> >-	if (up->capabilities & UART_CAP_AFE && port->fifosize >= 32) {
> >+	if ((up->capabilities & UART_CAP_AFE && (port->fifosize >= 32)) ||
> >+	    port->flags & UPF_HARD_FLOW) {
> 
> [Alan] Surely you want brackets on the port->flags & UPF_HARD_FLOW ??
> 
> The C precedence table shows following order:=
> -> & ||
> 
> So flags will be accessed first and then AND-ed with  UPF_HARD_FLOW and
> result will be OR-ed with left side expression value. So no need for bracket IMO.

Yep... agreed.

Alan
