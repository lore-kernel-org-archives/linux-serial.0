From: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/5] serial: 8250_pci: use DEFINE_PCI_DEVICE_TABLE macro
Date: Wed, 27 Nov 2013 20:07:50 -0800
Message-ID: <20131128040750.GA29917@kroah.com>
References: <000601ceebdc$ee148de0$ca3da9a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:55168 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213Ab3K1EHA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Nov 2013 23:07:00 -0500
Content-Disposition: inline
In-Reply-To: <000601ceebdc$ee148de0$ca3da9a0$%han@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-serial@vger.kernel.org, 'Angelo Butti' <buttiangelo@gmail.com>, 'Ian Abbott' <abbotti@mev.co.uk>, 'Heikki Krogerus' <heikki.krogerus@linux.intel.com>

On Thu, Nov 28, 2013 at 10:55:35AM +0900, Jingoo Han wrote:
> This macro is used to create a struct pci_device_id array.

Yeah, and it's a horrid macro that deserves to be removed, please don't
use it in more places.

Actually, if you could just remove it, that would be best, sorry, I'm
not going to take these patches.

greg k-h
