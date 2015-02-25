From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] serial: 8250_dw: Fix get_mctrl behaviour
Date: Wed, 25 Feb 2015 20:21:25 +0100
Message-ID: <3836329.RsbZqYqPAB@wuerfel>
References: <1424891056-1222-2-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424891056-1222-2-git-send-email-jonathar@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Richardson <jonathar@broadcom.com>
Cc: Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Scott Branden <sbranden@broadcom.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wednesday 25 February 2015 11:04:16 Jonathan Richardson wrote:
> +- msr-override : array of strings to be used to override the individual
> +  modem status signals for DCD, DSR, CTS, and RI.  If the property is not
> +  present, the individual signals are obtained from the modem status register.
> +  Strings accepted are "dcd", "dsr", "cts", and "ri". If "dcd", "dsr", or
> +  "cts" are present, these signals will always be reported as active. If
> +  "ri" is present, this signal will always be reported as inactive.
> 

Did you copy this definition from another driver? If not, we should try
to come up with a more natural way to do it. How about defining four
boolean properties instead, like

	dcd-override
	dsr-override
	cts-override
	ri-override

Simplifies the parser and the binding.

	Arnd
