From: Greg KH <greg@kroah.com>
Subject: Re: [RFC PATCH 0/6] Rework tty helpers to avoid need for file
 pointers
Date: Thu, 17 Feb 2011 12:06:32 -0800
Message-ID: <20110217200632.GA27228@kroah.com>
References: <20110214162438.10571.8203.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110214162438.10571.8203.stgit@bob.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Feb 14, 2011 at 04:25:51PM +0000, Alan Cox wrote:
> (and then use this to fix the holes in hci_ath)
> 
> The cleanup wants doing anyway but we have a reason for needing to do it.

All now applied, including a build fix that you missed :)

thanks,

greg k-h
