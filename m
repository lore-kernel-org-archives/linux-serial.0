From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/3] tty/serial: Add RISC-V SBI earlycon support
Date: Wed, 5 Dec 2018 10:58:46 +0100
Message-ID: <20181205095846.GA9847@kroah.com>
References: <20181204135507.3706-1-anup@brainfault.org>
 <20181204135507.3706-2-anup@brainfault.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181204135507.3706-2-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Anup Patel <anup@brainfault.org>
Cc: Jiri Slaby <jslaby@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atish.patra@wdc.com>, Christoph Hellwig <hch@infradead.org>, Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Dec 04, 2018 at 07:25:05PM +0530, Anup Patel wrote:
> In RISC-V, the M-mode runtime firmware provide SBI calls for
> debug prints. This patch adds earlycon support using RISC-V
> SBI console calls. To enable it, just pass "earlycon=sbi" in
> kernel parameters.
> 
> Signed-off-by: Anup Patel <anup@brainfault.org>

This makes more sense to take through the riscv tree, so feel free to
add:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

to it and take it that way.

thanks,

greg k-h
