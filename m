From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/5] serial: delete the MCA specific 8250 support.
Date: Thu, 17 May 2012 09:46:10 -0700
Message-ID: <20120517164610.GA22327@kroah.com>
References: <1337272841-25931-1-git-send-email-paul.gortmaker@windriver.com>
 <1337272841-25931-4-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54496 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755099Ab2EQQqO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 May 2012 12:46:14 -0400
Received: by pbbrp8 with SMTP id rp8so2752050pbb.19
        for <linux-serial@vger.kernel.org>; Thu, 17 May 2012 09:46:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1337272841-25931-4-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, JBottomley@parallels.com, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

On Thu, May 17, 2012 at 12:40:39PM -0400, Paul Gortmaker wrote:
> The support for CONFIG_MCA is being removed, since the 20
> year old hardware simply isn't capable of meeting today's
> software demands on CPU and memory resources.
> 
> This commit removes the MCA specific 8250 UART code.
> 
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Do you want me to take this through my tty tree, or are you sending this
through some other means?

thanks,

greg k-h
