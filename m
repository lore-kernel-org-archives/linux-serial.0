From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2] pch_uart: Add MSI support
Date: Fri, 1 Jul 2011 15:32:09 -0700
Message-ID: <20110701223209.GA9581@kroah.com>
References: <4E02857C.1010304@dsn.okisemi.com>
 <1308812405-5245-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:50127 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757598Ab1GAWlZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Jul 2011 18:41:25 -0400
Content-Disposition: inline
In-Reply-To: <1308812405-5245-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jun 23, 2011 at 09:00:05AM +0200, Alexander Stein wrote:
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
> Changes in v2:
> * msi_enabled is stored in pci_dev already, skip it in our code

This doesn't apply to my tree, what kernel tree is it against?

greg k-h
