From: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH 1/3] tty/serial: Add RISC-V SBI earlycon support
Date: Fri, 07 Dec 2018 10:45:11 -0800 (PST)
Message-ID: <mhng-114b47e6-1722-4cae-9132-5998c74eef66@palmer-si-x1c4>
References: <20181205095846.GA9847@kroah.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205095846.GA9847@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: anup@brainfault.org, jslaby@suse.com, aou@eecs.berkeley.edu, atish.patra@wdc.com, Christoph Hellwig <hch@infradead.org>, robh@kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, 05 Dec 2018 01:58:46 PST (-0800), Greg KH wrote:
> On Tue, Dec 04, 2018 at 07:25:05PM +0530, Anup Patel wrote:
>> In RISC-V, the M-mode runtime firmware provide SBI calls for
>> debug prints. This patch adds earlycon support using RISC-V
>> SBI console calls. To enable it, just pass "earlycon=sbi" in
>> kernel parameters.
>>
>> Signed-off-by: Anup Patel <anup@brainfault.org>
>
> This makes more sense to take through the riscv tree, so feel free to
> add:
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> to it and take it that way.

It should be in my for-next now.

Thanks!
