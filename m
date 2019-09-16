From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
Date: Mon, 16 Sep 2019 14:15:18 +0200
Message-ID: <20190916121518.GA29881@lst.de>
References: <20190910055923.28384-1-hch@lst.de> <mvm4l1kskny.fsf@suse.de> <20190910070503.GA31743@lst.de> <mvmzhjcr2d4.fsf@suse.de> <alpine.DEB.2.21.9999.1909160456010.7214@viisi.sifive.com> <mvm7e68fo2g.fsf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <mvm7e68fo2g.fsf@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Christoph Hellwig <hch@lst.de>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Sep 16, 2019 at 02:00:39PM +0200, Andreas Schwab wrote:
> > Try:
> >
> >     earlycon=sifive,0x10010000
> 
> That's not what Christoph wants.

Well, what I want is auto selection if the device tree uses the
stdout-path.  My Kendryte DT uses that and it works like a charm.  If
it doesn't work for you on the U54 board chances are that your DT
doesn't have the right settings and you have to use the line that
Paul posted.
