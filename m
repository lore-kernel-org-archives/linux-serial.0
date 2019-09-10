From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
Date: Tue, 10 Sep 2019 16:36:30 +0200
Message-ID: <20190910143630.GA6794@lst.de>
References: <20190910055923.28384-1-hch@lst.de> <mvm4l1kskny.fsf@suse.de> <20190910070503.GA31743@lst.de> <mvmzhjcr2d4.fsf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <mvmzhjcr2d4.fsf@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, gregkh@linuxfoundation.org, jslaby@suse.com, paul.walmsley@sifive.com, linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 10, 2019 at 10:18:15AM +0200, Andreas Schwab wrote:
> > How so?  Wіth OF and a stdout path you just set earlycon on the
> > command line without any arguments and it will be found.
> 
> Doesn't work for me.
> 
> [    0.000000] Malformed early option 'earlycon'

That functionality is implemented by param_setup_earlycon and
early_init_dt_scan_chosen_stdout.  Check why those aren't built into
your kernel.
