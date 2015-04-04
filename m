From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v4] earlycon: 8250: Fix command line regression
Date: Sat, 04 Apr 2015 13:24:51 -0400
Message-ID: <55201E63.6040505@hurleysoftware.com>
References: <1428157650-16418-1-git-send-email-peter@hurleysoftware.com> <1428167961-26841-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428167961-26841-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-serial@vger.kernel.org

On 04/04/2015 01:19 PM, Peter Hurley wrote:
> Restore undocumented behavior of kernel command line parameters of
> the forms:
>     console=uart[8250],io|mmio|mmio32,<addr>[,options]
>     console=uart[8250],<addr>[,options]
> where 'options' have not been specified; in this case, the hardware
> is assumed to be initialized.
> 
> Document the required behavior of the original implementation.

Greg,

Please wait for a Tested-by from Yinghai before pushing; I have no
platform to test if this fixes his regression.

Regards,
Peter Hurley
