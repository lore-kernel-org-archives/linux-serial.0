From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH stable v2 1/2] termios, tty/tty_baudrate.c: fix buffer
 overrun
Date: Tue, 23 Oct 2018 13:14:57 -0700
Message-ID: <93f9d420-99e4-b84a-930f-a459f53a5ef7@zytor.com>
References: <20181022161905.26589-1-hpa@zytor.com>
 <20181023145351.GA28516@kroah.com>
 <DD4A5EC1-E0A8-4DB0-907F-F334C27CE54D@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DD4A5EC1-E0A8-4DB0-907F-F334C27CE54D@zytor.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Eugene Syromiatnikov <esyr@redhat.com>, linux-alpha@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 10/23/18 09:02, hpa@zytor.com wrote:
>>
>> As I think Al's big termios cleanups are going to be hitting Linus's
>> tree soon, do you know how these patches interact with that?
>>
>> This patch seems like it will not, so I'll be glad to queue that up
>> after my first round of patches get merged to Linus later this week,
>> but
>> the second one worries me.
>>
>> thanks,
>>
>> greg k-h
> 
> I have been working with Al; we had approached much the same problems but from different directions. Mine ended up being a bit more comprehensive as a result, so I think we're going to end up using my code with Al's reviews.
> 
> So bottom line is that it should be all good.
> 

[Al: Feel free to yell at me if I got that wrong.]

	-hpa
