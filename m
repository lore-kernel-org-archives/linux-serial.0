From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Mon, 25 Jan 2016 11:36:52 +0100
Message-ID: <6B29CADF-1A06-4E38-9D29-2A78CAD5F665@goldelico.com>
References: <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com> <20160116233157.GA7774@rob-hp-laptop> <3D5F35D7-31B5-4E68-875F-7DD492EF0316@goldelico.com> <20160117141912.4aa2e46c@lxorguk.ukuu.org.uk> <1D5F146E-D347-453B-9158-8D269F8DA99C@goldelico.com> <20160117193849.69d00c28@lxorguk.ukuu.org.uk> <37DCE36D-0A5E-41C5-BDA4-857DCF9F2DD1@goldelico.com> <20160118111926.0882b422@lxorguk.ukuu.org.uk> <07F3B6C0-0C87-478C-B6DD-5C0EECB42D0D@goldelico.com> <20160118220319.051c9cc0@lxorguk.ukuu.org.uk> <C1E6AFE7-1EF2-4C70-8BE2-82F5CD7DDE22@goldelico.com> <9E37C552-361C-4A54-980E-E3BFFF834302@goldelico.com> <20160120174610.1c64239a@lxorguk.ukuu.org.uk> <39B850CE-E381-4D3B-BD0A-84AFE7DAEEDF@goldelico.com> <CAAObsKB4oFeM9Cjet5z+vz0S1M8RZ3jFt03b38KXq+sh6f5EwA@mail.gmail.com> <20160122201229.5df0bb2d@lx
 orguk.ukuu.org.uk> <DF404071-9FD0-4B33-B1B5-EC14192655E7@goldelico.com> <20160123172830.51933d2d@lxorguk.ukuu.org.uk> <68E21655-A8A1-431B-BBB9-3B43AFC0B03A@goldelico.com> <20160124171053.5f15b92c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160124171053.5f15b92c@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Rob Herring <robh@kernel.org>, Vostrikov Andrey <andrey.vostrikov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robherring2@gmail.com>, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Marek Belisko <marek@goldelico.com>
List-Id: linux-serial@vger.kernel.org

Hi Alan,

Am 24.01.2016 um 18:10 schrieb One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>:

>>> but by having only the
>>> minimum necessary in the kernel. Unix  
>> 
>> I think you are confusing it with the goals of microkernels (e.g. Mach or Hurd).
> 
> No and the quote below is from Doug McIlroy - who amongst other thing
> invented pipes.

Which is a brilliant concept.

> 
>>> 
>>> "We used to sit around in the Unix Room saying, 'What can we throw out?
>>> Why is there this option?" - Doug McIlroy  

Maybe I am interpreting differently, but "throwing out unnecessary things from
Unix" is logically not the same as "having the minimum necessary in the kernel".

The latter appears to be implying to do *everything* which can be done in user space.
This is what I mean that the goal of throwing out everything not necessary from the
kernel leads to micro-kernel concepts. And neither Unix nor Linux did throw out
enough to become a microkernel. So they still have components which could be
thrown out and moved to user space.

And Unix is kernel + user space. So the citation could also mean that they did
throw out (and simplify) concepts in both areas. Not only from the kernel. So they
did balance and optimize the whole system (which is what I want to achieve as well).

Unfortunately I never had a chance to meet one of the Unix inventors, so I
can't ask them what they really meant and how they did work.

But anyways, this is discussing the wrong problem on the wrong level.

People out there (and me included) would like to hide or better, easier and
more systematically access devices directly connected on the same PCB to
a specific UART. And can't. Or can do only with ugly or inefficient solutions.

>From that we come to this fundamental discussion level because you say that
Linux should be a kernel which should only support the minimum. Therefore our
requests are rejected, because it could be solved by blowing up the user space.

This is IMHO your very valid opinion, but it is not a guideline that I observe when
going through the source tree. There are tons of things that could be done
in user space (e.g. what are all those I2C device drivers good for? /dev/i2c should
suffice to control every device from user space. What is iio good for in the kernel?
a library could translate everything into iio interfaces).

So this discrepancy is what I criticize because I don't see a basic rule or
design principle behind what is acceptable and what is not.

If it exists, please point me to it. I am open to learn about that.

> 
>> Most GPS receivers I came across are modules which spit out NMEA
>> records with serial 9600 bit/s. Either through RS232 or Bluetooth SPP. There
>> may be others, but I don't want to have all problems of the world solved
>> at once.
> 
> The kernel lives in the big world, not your personal fiefdom

Every contribution initially looks at the area, the contributor is aware of and
knows best and does not find a solution using existing hooks. Then discussion
starts.

But what a contributor can't (and should never) accept is if his problem is
simply declared to be a non-problem without providing a *better* alternative
solution for it. Better for everybody including the contributor.

> 
> *PLONK*

Thanks.

Well, I have to apologize that I was not yet aware who hides behind the
"one thousand gnomes" e-mail address... Because I judge discussion partners
by what they say now and how they help to solve my actual problem for the future
(and not what they have done in the past).

So you do have a lot of experience with Linux history. And you are amongst
the handful of persons who know every detail of the Linux kernel. That is good
because it shows that you can really influence how this discussion ends.

But sometimes experience could be a little blocking to new ideas and experiences
not related to Linux (e.g. close to hardware or embedded design) brought in by
newcomers.

And it collides with my belief that everything can be done, if people want.

Now, how can we help those who want (for IMHO very understandable reasons)
to access a specific UART from kernel modules?

-- hns
