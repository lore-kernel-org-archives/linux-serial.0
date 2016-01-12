From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Tue, 12 Jan 2016 14:28:00 +0100
Message-ID: <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com>
References: <20150511013540.5709.93626.stgit@notabene.brown> <CAAObsKD7-02HVUosXVwqcH6HyGEGYJ9jdNepuNhLiiL+ujO5iw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAObsKD7-02HVUosXVwqcH6HyGEGYJ9jdNepuNhLiiL+ujO5iw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: List for communicating with real GTA04 owners <gta04-owner@goldelico.com>, tomeu@tomeuvizoso.net
Cc: NeilBrown <neil@brown.name>, Mark Rutland <mark.rutland@arm.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robherring2@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-serial@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Marek Belisko <marek@goldelico.com>
List-Id: linux-serial@vger.kernel.org

Hi Tomeu,

Am 12.01.2016 um 14:06 schrieb Tomeu Vizoso <tomeu@tomeuvizoso.net>:

> On 11 May 2015 at 03:56, NeilBrown <neil@brown.name> wrote:
>> Hi all,
>> here is version 4 of my "UART slave device" patch set, previously
>> known as "tty slave devices".
> 
> Hi Neil,
> 
> do you (or someone else) have plans to continue this work in the short
> or medium term?

yes, there is something in our upstreaming pipeline. This one works for us on top of 4.4.0:

<http://git.goldelico.com/?p=gta04-kernel.git;a=shortlog;h=refs/heads/work/hns/misc/w2sg-tty-slave2-v4>

There is one point still to be solved: the exact style of the DT bindings.

We have an idea how a driver can implement two different styles (child node AND phandle)
so that it is up to the DTS developer to use the one that best fits into the existing DTS.
 
BR,
Nikolaus
