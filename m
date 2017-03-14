From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3] Revert "tty: serial: pl011: add ttyAMA for matching
 pl011 console"
Date: Tue, 14 Mar 2017 16:14:04 +0000
Message-ID: <d1e067f1-e82f-7692-bcc2-e3549887be63@arm.com>
References: <20170301122602.30025-1-aleksey.makarov@linaro.org>
 <20170301152304.29635-1-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170301152304.29635-1-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>, linux-serial@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>
List-Id: linux-serial@vger.kernel.org



On 01/03/17 15:23, Aleksey Makarov wrote:
> The original patch makes the condition always true, so it is wrong.
> 
> It masks (but not fixes) the bug described in the commit message
> but introduces a regression (no console is selected by SPCR)
> in regular (no 'console=ttyAMA') case.
> 
> s/||/&&/ would not fix the problem as the root cause was identified
> incorrectly.
> 
> This reverts commit aea9a80ba98a0c9b4de88850260e9fbdcc98360b.
> 

Sorry for that, I will test your patches and respond to that. For this
patch:

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
