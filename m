From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
Date: Mon, 16 Sep 2019 08:42:53 +0200
Message-ID: <20190916064253.GA24654@lst.de>
References: <20190910143630.GA6794@lst.de> <mhng-218f6b9f-bfd8-4adb-8147-298989494bcf@palmer-si-x1e>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <mhng-218f6b9f-bfd8-4adb-8147-298989494bcf@palmer-si-x1e>
Sender: linux-kernel-owner@vger.kernel.org
To: Palmer Dabbelt <palmer@sifive.com>
Cc: schwab@suse.de, Christoph Hellwig <hch@lst.de>, Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 13, 2019 at 01:40:27PM -0700, Palmer Dabbelt wrote:
> OpenEmbedded passes "earlycon=sbi", which I can find in the doumentation.  
> I can't find anything about just "earlycon".  I've sent a patch adding sbi 
> to the list of earlycon arguments.

earlycon without arguments is documented, although just for ARM64.
I can send a patch to update it to properly cover all DT platforms
in addition.
