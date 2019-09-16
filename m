From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
Date: Mon, 16 Sep 2019 14:00:39 +0200
Message-ID: <mvm7e68fo2g.fsf@suse.de>
References: <20190910055923.28384-1-hch@lst.de> <mvm4l1kskny.fsf@suse.de>
        <20190910070503.GA31743@lst.de> <mvmzhjcr2d4.fsf@suse.de>
        <alpine.DEB.2.21.9999.1909160456010.7214@viisi.sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.9999.1909160456010.7214@viisi.sifive.com> (Paul
        Walmsley's message of "Mon, 16 Sep 2019 04:57:14 -0700 (PDT)")
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Christoph Hellwig <hch@lst.de>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sep 16 2019, Paul Walmsley <paul.walmsley@sifive.com> wrote:

> On Tue, 10 Sep 2019, Andreas Schwab wrote:
>
>> On Sep 10 2019, Christoph Hellwig <hch@lst.de> wrote:
>> 
>> > On Tue, Sep 10, 2019 at 08:57:37AM +0200, Andreas Schwab wrote:
>> >> On Sep 10 2019, Christoph Hellwig <hch@lst.de> wrote:
>> >> 
>> >> > The sifive serial driver implements earlycon support,
>> >> 
>> >> It should probably be documented in admin-guide/kernel-parameters.txt.
>> >
>> > How so?  Wіth OF and a stdout path you just set earlycon on the
>> > command line without any arguments and it will be found.
>> 
>> Doesn't work for me.
>> 
>> [    0.000000] Malformed early option 'earlycon'
>
> Try:
>
>     earlycon=sifive,0x10010000

That's not what Christoph wants.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
