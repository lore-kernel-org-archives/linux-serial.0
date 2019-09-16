From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
Date: Mon, 16 Sep 2019 14:22:49 +0200
Message-ID: <20190916122249.GA30058@lst.de>
References: <20190910055923.28384-1-hch@lst.de> <mvm4l1kskny.fsf@suse.de> <20190910070503.GA31743@lst.de> <mvmzhjcr2d4.fsf@suse.de> <alpine.DEB.2.21.9999.1909160456010.7214@viisi.sifive.com> <mvm7e68fo2g.fsf@suse.de> <alpine.DEB.2.21.9999.1909160513100.9917@viisi.sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1909160513100.9917@viisi.sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Andreas Schwab <schwab@suse.de>, Christoph Hellwig <hch@lst.de>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Sep 16, 2019 at 05:18:57AM -0700, Paul Walmsley wrote:
> I support Christoph's plan to add generic implicit earlycon support.

I'm not planning to add it, it exist already.  You just need a DT that
sets the stdout node up properly, and a earlycon driver using
OF_EARLYCON_DECLARE like the sifive uart driver.

The DT here for example works perfectly fine:

http://git.infradead.org/users/hch/riscv.git/commitdiff/f10e64873eafc68516b8884c06b9290b9887633b
