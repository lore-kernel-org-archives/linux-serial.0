From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
Date: Mon, 16 Sep 2019 21:40:10 +0200
Message-ID: <87ftkwdo85.fsf@igel.home>
References: <20190916064253.GA24654@lst.de>
        <mhng-671404fb-c86e-444a-86fb-b1ba027b1c36@palmer-si-x1c4>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <mhng-671404fb-c86e-444a-86fb-b1ba027b1c36@palmer-si-x1c4>
        (Palmer Dabbelt's message of "Mon, 16 Sep 2019 09:12:09 -0700 (PDT)")
Sender: linux-kernel-owner@vger.kernel.org
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Christoph Hellwig <hch@lst.de>, Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Sep 16 2019, Palmer Dabbelt <palmer@sifive.com> wrote:

> On Sun, 15 Sep 2019 23:42:53 PDT (-0700), Christoph Hellwig wrote:
>> On Fri, Sep 13, 2019 at 01:40:27PM -0700, Palmer Dabbelt wrote:
>>> OpenEmbedded passes "earlycon=sbi", which I can find in the doumentation.
>>> I can't find anything about just "earlycon".  I've sent a patch adding sbi
>>> to the list of earlycon arguments.
>>
>> earlycon without arguments is documented, although just for ARM64.
>> I can send a patch to update it to properly cover all DT platforms
>> in addition.
>
> Thanks.  I've kind of lost track of the thread, but assuming that does the
> "automatically pick an earlycon" stuff then that's probably what we should
> be using in the distros.

Except that it doesn't work.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
