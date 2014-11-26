From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH V3 0/7] serial: Configure {big,native}-endian MMIO
 accesses via DT
Date: Wed, 26 Nov 2014 13:14:52 +0000
Message-ID: <CACxGe6uifCPz6RM59MVODWo2WGoVBMWSFzmL9Uz3AVJ0C9-hig@mail.gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
 <20141125151018.359EAC44343@trevor.secretlab.ca> <20141125173859.GA27287@kroah.com>
 <20141125211116.GA9997@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:48840 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbaKZNPN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Nov 2014 08:15:13 -0500
Received: by mail-ig0-f180.google.com with SMTP id h15so2550143igd.7
        for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2014 05:15:13 -0800 (PST)
In-Reply-To: <20141125211116.GA9997@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Kevin Cernekee <cernekee@gmail.com>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Florian Fainelli <f.fainelli@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-mips <linux-mips@linux-mips.org>

On Tue, Nov 25, 2014 at 9:11 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, Nov 25, 2014 at 09:38:59AM -0800, Greg KH wrote:
>> On Tue, Nov 25, 2014 at 03:10:18PM +0000, Grant Likely wrote:
>> > On Mon, 24 Nov 2014 15:36:15 -0800
>> > , Kevin Cernekee <cernekee@gmail.com>
>> >  wrote:
>> > > My last submission attempted to work around serial driver coexistence
>> > > problems on multiplatform kernels.  Since there are still questions
>> > > surrounding the best way to solve that problem, this patch series
>> > > will focus on the narrower topic of big endian MMIO support on serial.
>> > >
>> > >
>> > > V2->V3:
>> > >
>> > >  - Document the new DT properties.
>> > >
>> > >  - Add libfdt-based wrapper, to complement the "struct device_node" based
>> > >    version.
>> > >
>> > >  - Restructure early_init_dt_scan_chosen_serial() changes to use a
>> > >    temporary variable, so it is easy to add more of_setup_earlycon()
>> > >    properties later.
>> > >
>> > >  - Make of_serial and serial8250 honor the new "big-endian" property.
>> > >
>> > >
>> > > This series applies cleanly to:
>> > >
>> > > git://git.kernel.org/pub/scm/linux/kernel/git/glikely/linux.git devicetree/next-overlay
>> > >
>> > > but was tested on the mips-for-linux-next branch because my BE platform
>> > > isn't supported in mainline yet.
>> >
>> > For the whole series:
>> > Acked-by: Grant Likely <grant.likely@linaro.org>
>> >
>> > Greg, which tree do you want to merge this through? My DT tree, or the
>> > tty tree?
>>
>> I can take these through my tty tree, thanks.
>
> I take that back, it doesn't apply to my tty tree due to changes in the
> of codebase.  So feel free to take all of these through your DT tree
> please:
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied all 7 patches. Thanks.

g.
