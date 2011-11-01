From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] UART: add CSR SiRFprimaII SoC on-chip uart drivers
Date: Tue, 1 Nov 2011 21:28:39 +0800
Message-ID: <CAGsJ_4ySO=ACfAeeHMvw_sOUdaD9KYD09f4LYrWdUkA2PwuLvA@mail.gmail.com>
References: <1319772453-1275-1-git-send-email-Barry.Song@csr.com>
 <20111028071129.GA2362@tarshish> <CAGsJ_4z=VtU+RJ4c0Y2ruttWU6mTVtHMxzvCYWGz=5w6i7QJMQ@mail.gmail.com>
 <20111101114242.7c90f958@bob.linux.org.uk> <CAGsJ_4wGRv9=fbWtK-0jkmXDcd=y2r6qxae99tNgim4=BmxJ+w@mail.gmail.com>
 <20111101131021.GA9109@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111101131021.GA9109@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@linux.intel.com>, torvalds@linux-foundation.org, Baruch Siach <baruch@tkos.co.il>, Rong Wang <Rong.Wang@csr.com>, Bin Shi <Bin.Shi@csr.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, workgroup.linux@csr.com, linux-serial@vger.kernel.org, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

2011/11/1 Greg KH <greg@kroah.com>:
> On Tue, Nov 01, 2011 at 08:48:29PM +0800, Barry Song wrote:
>> 2011/11/1 Alan Cox <alan@linux.intel.com>:
>> >> i am not sure whether i will make Linus confused if i send a new
>> >> version at this moment. how about i send a seperate patch to fix =
this
>> >> after the driver is applied?
>> >
>> > That would be the best idea - its a trivial typo so doesn't really
>> > matter much.
>> ok, Alan.
>>
>> Linus, have you gotten it? and can you apply it?
>> or do you want this to go through tty tree and merge it until next m=
erge window?
>
> That's probably the easiest thing to do, right? =C2=A0Send it to me a=
nd I can
> handle it.

Hi Greg, thanks! as i checked your tree, this patch should be able to
apply on your tree since you already have pinmux subsystem.
do i need to git send-email to you again for this?

>
> thanks,
>
> greg k-h
>

-barry
