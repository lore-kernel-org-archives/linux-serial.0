From: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
Date: Fri, 13 Sep 2019 13:40:27 -0700 (PDT)
Message-ID: <mhng-218f6b9f-bfd8-4adb-8147-298989494bcf@palmer-si-x1e>
References: <20190910143630.GA6794@lst.de>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190910143630.GA6794@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Cc: schwab@suse.de, Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>
List-Id: linux-serial@vger.kernel.org

On Tue, 10 Sep 2019 07:36:30 PDT (-0700), Christoph Hellwig wrote:
> On Tue, Sep 10, 2019 at 10:18:15AM +0200, Andreas Schwab wrote:
>> > How so?  Wіth OF and a stdout path you just set earlycon on the
>> > command line without any arguments and it will be found.
>> 
>> Doesn't work for me.
>> 
>> [    0.000000] Malformed early option 'earlycon'
>
> That functionality is implemented by param_setup_earlycon and
> early_init_dt_scan_chosen_stdout.  Check why those aren't built into
> your kernel.

OpenEmbedded passes "earlycon=sbi", which I can find in the doumentation.  I 
can't find anything about just "earlycon".  I've sent a patch adding sbi to the 
list of earlycon arguments.
