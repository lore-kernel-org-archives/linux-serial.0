From: Bastian Hecht <hechtb@gmail.com>
Subject: Re: [PATCH v3 1/3] serial: sh-sci: Add OF support
Date: Thu, 28 Feb 2013 13:20:59 -0600
Message-ID: <CABYn4sxFODwPD5ayYLgHuFzG6+XQ6ZpVgnx-Nz8MkhBv35LqAQ@mail.gmail.com>
References: <1361898208-6683-1-git-send-email-hechtb+renesas@gmail.com>
	<20130227080742.GB21690@linux-sh.org>
	<CANqRtoSDqm1VMZxxuPgnpNScfSVsozeS=_m0-1t6Z1w0vny7FA@mail.gmail.com>
	<20130227081954.GA30395@linux-sh.org>
	<CANqRtoRXjiX227Mop2ysGDij0F0W-c-_xq4UMn7K-Hhmg-e=4Q@mail.gmail.com>
	<20130227090456.GA7936@verge.net.au>
	<20130227093439.GE30395@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:61480 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618Ab3B1TU7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Feb 2013 14:20:59 -0500
In-Reply-To: <20130227093439.GE30395@linux-sh.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org

2013/2/27 Paul Mundt <lethal@linux-sh.org>:
> On Wed, Feb 27, 2013 at 06:04:57PM +0900, Simon Horman wrote:
>> On Wed, Feb 27, 2013 at 05:26:57PM +0900, Magnus Damm wrote:
>> > My personal preference would be that you (Paul) merge this patch by yourself:
>> > [PATCH v3 1/3] serial: sh-sci: Add OF support
>> >
>> > I believe we can deal with the SoC bits easily afterwards. Simon may
>> > however prefer to deal with it differently.
>> >
>> > Simon, how do you prefer to handle merge of DT support for the SCIF driver?
>>
>> I am fairly ambivalent.
>>
>> If Paul could merge this patch upstream in the v3.9-rc1~rc3 time frame
>> then I can queue up the SoC portions for v3.10.
>>
>> Or alternatively I can queue up all three patches for v3.10.
>> Either way the outcome should be much the same.
>
> Waiting an entire kernel version to throw some arbitrary dts file updates
> in seems a bit absurd, but I'll let you handle it however you like. I
> haven't sent out my SH updates to Linus yet, but plan to do so by -rc2
> (there isn't really that much to begin with, most of it has gone through
> other trees), so in light of this I will throw the sh-sci OF patch in to
> my queue directly then.

Thanks to all involved getting this patch into the mainline.
