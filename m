From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
Date: Tue, 17 Sep 2019 09:43:25 +0200
Message-ID: <mvma7b3e5b6.fsf@suse.de>
References: <mhng-5091669f-461c-4e62-a71c-e16957801fad@palmer-si-x1c4>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <mhng-5091669f-461c-4e62-a71c-e16957801fad@palmer-si-x1c4>
        (Palmer Dabbelt's message of "Mon, 16 Sep 2019 14:38:39 -0700 (PDT)")
Sender: linux-kernel-owner@vger.kernel.org
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Christoph Hellwig <hch@lst.de>, Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Sep 16 2019, Palmer Dabbelt <palmer@sifive.com> wrote:

> but we don't set it for the HiFive Unleashed.  I'd call that a bug,
> something like this
>
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> index 93d68cbd64fe..6d0ec76d93fe 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> @@ -13,6 +13,7 @@
>        compatible = "sifive,hifive-unleashed-a00", "sifive,fu540-c000";
>
>        chosen {
> +               stdout-path = &uart0;
>        };
>
>        cpus {
>
> should fix it.  LMK if I've misunderstood something.

If that's how it's supposed to work, ok.  Other platforms add it in
u-boot.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
