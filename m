From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>
Subject: Re: [PATCH] serial: mxs-auart: add sysrq support
Date: Mon, 06 Oct 2014 13:34:25 +0200
Message-ID: <54327E41.9070607@elproma.com.pl>
References: <20140929014129.GA8687@kroah.com>	<1411999905-27044-1-git-send-email-j.uzycki@elproma.com.pl> <CAOMZO5Cctk4UNvK2=MC9tf2Fzi1r0+qdn-SXfC-=W9n3T=a+VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:57205 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751488AbaJFLe2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Oct 2014 07:34:28 -0400
In-Reply-To: <CAOMZO5Cctk4UNvK2=MC9tf2Fzi1r0+qdn-SXfC-=W9n3T=a+VA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, Richard Genoud <richard.genoud@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

W dniu 2014-10-04 18:19, Fabio Estevam pisze:
> Janusz,
>
> On Mon, Sep 29, 2014 at 11:11 AM, Janusz Uzycki <j.uzycki@elproma.com.pl> wrote:
>>> So I'm deleting all of these now, please resend the latest
>>> versions you have, with properly versioning
>>> and order information.
>> Sure. If you don't want to comment dirty patches
>> I will not send you them.
>> I can send you only the final version, commented before.
>>
>> On the moment this patch is ready to apply.
>>
>> [PATCH RESEND] serial: mxs-auart: add sysrq support
>> The patch is resent to apply.
> What Greg is asking you to do is to provide a proper version
> annotation in your patches.
>
> For example: [PATCH v2] serial: mxs-auart: add ...
>
> Then if you need to submit it again you should do:
>
> [PATCH v3] serial: mxs-auart: add ...

I will resend the rest of patches (as v4) this week.
This simple patch is independent from the previous patchset so
I decided to resubmit it alone ([PATCH RESEND] header used)
to apply.

I rather shouldn't resend the patch again I guess.
I sent the same initial version of the patch twice
after Greg's email so I did mess enough I think.

> Also, always explain below the --- line what changed from one version to another
I thought composing cover letter is the only solution for resent patch 
or series.
As I understood this way is appropriate for single patch only (not patch 
set).
"Below" - it means between the line and diffstat?
Should I add new/second '---' line before diffstat?

best regards
Janusz

