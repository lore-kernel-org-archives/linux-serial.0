From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] tty/serial: emit CR before NL in RISC-V SBL console
Date: Thu, 10 Jan 2019 16:26:46 +0100
Message-ID: <mvm7efcedop.fsf@suse.de>
References: <20181204135507.3706-1-anup@brainfault.org>
        <20181204135507.3706-2-anup@brainfault.org>
        <mvmbm4oehd5.fsf_-_@suse.de>
        <CAAhSdy3-SaP7RBbgx7kZgkkxeN2W-Ue8QDFXkOgFG5GiAg52-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAhSdy3-SaP7RBbgx7kZgkkxeN2W-Ue8QDFXkOgFG5GiAg52-g@mail.gmail.com>
        (Anup Patel's message of "Thu, 10 Jan 2019 20:46:51 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Anup Patel <anup@brainfault.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atish.patra@wdc.com>, Christoph Hellwig <hch@infradead.org>, Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org, "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Jan 10 2019, Anup Patel <anup@brainfault.org> wrote:

> Instead of doing '\n' handling here, we should do it in BBL or
> OpenSBI (i.e. SBI runtime firmware) otherwise all users of
> SBI_CONSOLE_PUTCHAR (namely, Linux, FreeBSD,
> FreeRTOS, U-Boot S-mode, etc) will endup having '\n'
> handling.

I don't think the serial driver should do NLCR handling on its own,
without being instructed by the tty layer.  Since the earlycon does not
have a tty layer, it needs to handle it explicitly.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
