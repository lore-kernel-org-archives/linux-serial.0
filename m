From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] tty/serial: use uart_console_write in the RISC-V SBL
 early console
Date: Tue, 15 Jan 2019 05:59:54 -0800
Message-ID: <20190115135954.GM28946@infradead.org>
References: <20181204135507.3706-1-anup@brainfault.org>
 <20181204135507.3706-2-anup@brainfault.org>
 <mvmbm4oehd5.fsf_-_@suse.de>
 <CAAhSdy3-SaP7RBbgx7kZgkkxeN2W-Ue8QDFXkOgFG5GiAg52-g@mail.gmail.com>
 <mvm7efcedop.fsf@suse.de>
 <CAAhSdy0suSgKpdz+NUrXzS9Ozp75hMC6ovW4yLf5s0KYJwwocw@mail.gmail.com>
 <mvmsgy0cu9g.fsf_-_@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <mvmsgy0cu9g.fsf_-_@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Palmer Dabbelt <palmer@sifive.com>, "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Atish Patra <atish.patra@wdc.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-riscv@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 10, 2019 at 06:11:39PM +0100, Andreas Schwab wrote:
> This enables proper NLCR processing.
> 
> Suggested-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Andreas Schwab <schwab@suse.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
