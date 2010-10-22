From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] serial: msm_serial_hs: Add MSM high speed UART driver
Date: Fri, 22 Oct 2010 07:09:46 -0700
Message-ID: <20101022140946.GB2651@kroah.com>
References: <1287729586-12003-1-git-send-email-sankalpb@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:47944 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757099Ab0JVOKB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Oct 2010 10:10:01 -0400
Content-Disposition: inline
In-Reply-To: <1287729586-12003-1-git-send-email-sankalpb@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sankalp Bose <sankalpb@codeaurora.org>
Cc: linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, Nick Pelly <npelly@google.com>

On Fri, Oct 22, 2010 at 12:09:46PM +0530, Sankalp Bose wrote:
> This driver supports UART-DM HW on MSM platforms. It uses the on
> chip DMA to drive data transfers and has optional support for UART
> power management independent of Linux suspend/resume and wakeup
> from Rx.
> 
> The driver was originally developed by Google. It is functionally
> equivalent to the version available at:
> http://android.git.kernel.org/?p=kernel/experimental.git
> the differences being:
> 1) Remove wakelocks and change unsupported DMA API.
> 2) Replace clock selection register codes by macros.
> 3) Fix checkpatch errors and add inline documentation.
> 4) Add runtime PM hooks for active power state transitions.
> 
> CC: Nick Pelly <npelly@google.com>
> Signed-off-by: Sankalp Bose <sankalpb@codeaurora.org>

You did see my "the serial tree is closed for .37 merges" message
yesterday, right?

Please resend this after 2.6.37-rc1 is out if you wish for it to be
considered for .38.

thanks,

greg k-h
