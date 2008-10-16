From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH 2/6] Blackfin Serial Driver: Add a debug function to serial driver.
Date: Thu, 16 Oct 2008 21:58:21 +0800
Message-ID: <386072610810160658i17ba05e0la6d2251fcb269f3d@mail.gmail.com>
References: <1223891185-13924-1-git-send-email-cooloney@kernel.org>
	 <1223891185-13924-3-git-send-email-cooloney@kernel.org>
	 <20081014142701.72090868@lxorguk.ukuu.org.uk>
	 <1224037421.6284.40.camel@dyang>
	 <20081015083811.GA21237@shell.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:57619 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbYJPN6Y (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Oct 2008 09:58:24 -0400
Received: by gxk9 with SMTP id 9so8284029gxk.13
        for <linux-serial@vger.kernel.org>; Thu, 16 Oct 2008 06:58:22 -0700 (PDT)
In-Reply-To: <20081015083811.GA21237@shell.devel.redhat.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: gyang <graf.yang@analog.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Wed, Oct 15, 2008 at 4:38 PM, Alan Cox <alan@redhat.com> wrote:
> On Wed, Oct 15, 2008 at 10:23:41AM +0800, gyang wrote:
>> We are making a SMP like patch to blackfin, cpu_relax() is replaced by a
>> data cache flush function which will count it to a per-cpu counter.
>> If this serial function is called too early, the per-cpu data area have
>> not been initialized, this call will cause crash.
>> So we'd like to use barrier() instead of cpu_relax().
>
> Can you split that out as a separate change and include the explanation in
> the patch then.
>
> Thanks
> Alan
>

I'll handle this and will resend the whole blackfin serial driver
patches again as well as Sonic updates some bug fixing recently.

Thanks
-Bryan
