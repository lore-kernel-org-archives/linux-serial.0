From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: uart: add hw flow control support configuration
Date: Sat, 12 Apr 2014 17:58:12 +0100
Message-ID: <20140412175812.107ecbdf@alan.etchedpixels.co.uk>
References: <1397243877-23234-1-git-send-email-m-karicheri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1397243877-23234-1-git-send-email-m-karicheri2@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, balbi@ti.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

> not needed if hw has flow control capabilities. This patch adds a
> DT attribute for enabling hw flow control for a uart port. Also skip
> stop and start if this flag is present in flag field of the port
> structure.

That seems a sensible thing to add.

> -	if (up->capabilities & UART_CAP_AFE && port->fifosize >= 32) {
> +	if ((up->capabilities & UART_CAP_AFE && (port->fifosize >= 32)) ||
> +	    port->flags & UPF_HARD_FLOW) {

Surely you want brackets on the port->flags & UPF_HARD_FLOW ??

Alan
