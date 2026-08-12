Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B230FF30;
	Wed, 12 Aug 2026 06:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786517496; cv=none; b=GU0boLihAB11b0MiQJ5VUbEV5aJYHnQNSYG+rd/6/CK+qhyeAiqlDfL/Qhxdy2AsEo5ARdajDkaQb9S5tSn1sYv3+JAcAW0fgw1yLyLsp7/Cod1aHb7TdTT3blCIlikRKDQY3UAcu23yFr3OEM5QW8knvM5pQOI92Ex0FqJesWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786517496; c=relaxed/simple;
	bh=fxpplqLvvITIhXF4QPxYR/4nqdhRgvZfRMbmHQ0yONI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaZsKZ3oUeeysaoIrFSliaWQi6JwG1pKc3+CwPbtMD3fzwfya5fNy5jN9o/M0rL7yzkAogUVSckDeqYIORiNLl9m0AekulcDJgPAsxQw7umm5NXQuJWhbsygj8gJs8hhiZmsxWn8ieFPI3qkO0GgEn1IPYBuz/riDr0ih697jFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7XNdxqJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7XNdxqJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786517495; x=1818053495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fxpplqLvvITIhXF4QPxYR/4nqdhRgvZfRMbmHQ0yONI=;
  b=V7XNdxqJq858rJhCXa0Olt+JvFNc4MLlYUkBKO/F1FEfHLDTdOIke/Ql
   RSRuwUR6csfIQnroNJQfTsTpJkiiNDz+oSp0PEHTI5sXxtfWotDs7XYdH
   yyyDYH4CNco21KjFxeRWqnJPjWP72/XhEA5ZMTnlQLuu5Xq6H8o0WxUTM
   LXe5MA7118irauJ5WH6DGL9sibAe6rpER38ylHIfcgjq/fipODAJhH0/N
   VtLEl6WAojg6hwpRypxlrNAY+xPDR3AaHW2O485cZpnSjJtoIZO0y5Af/
   cifvY7VJCRlLrYHP7wTMyzBZJM5Vr0ya3QWm30VI0HEdWIuerKOb/B/AA
   Q==;
X-CSE-ConnectionGUID: 56mhCmmmQ6Czlv0YlP1iRw==
X-CSE-MsgGUID: JNpFqNSRQWaeS3PjAHwEMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="90937636"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="90937636"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 23:51:34 -0700
X-CSE-ConnectionGUID: +1CTwP1kRtmRZ4ehfeB2JQ==
X-CSE-MsgGUID: zqODPoOYT/6LTMSprfXorQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="262241273"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.92])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 23:51:31 -0700
Date: Wed, 12 Aug 2026 09:51:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Linus Walleij <linusw@kernel.org>,
	=?utf-8?B?TWljaGHFgiBLYXJkYcWb?= <mkmkl@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Vic Huang <vich@google.com>,
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] pinctrl / 8250_dw: Allow drivers to keep init
 pinctrl state until first open
Message-ID: <anwX8bn9emSOUOOJ@ashevche-desk.local>
References: <20260810130635.1166626-1-mkmkl@google.com>
 <CAD++jLnpZbmbZ_uQTS7pBdbmpvOZSy5+JsVP=Vb3HDhV8J-h4Q@mail.gmail.com>
 <CAD=FV=UzV=G_XLoDZ4zq0ZPSQ3ttUDX9oBJUQrLYfUQ6v35nsg@mail.gmail.com>
 <CAD++jL=WmAJNotpxqQkE9Yf3COxMcj=afDVGB2zi+ZN+mRocAg@mail.gmail.com>
 <CAD=FV=UoZ=CoUdku5aaJr9uihxr0Q-Yj4UQeQtYeODMzku7LkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UoZ=CoUdku5aaJr9uihxr0Q-Yj4UQeQtYeODMzku7LkA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 11, 2026 at 01:15:27PM -0700, Doug Anderson wrote:
> On Tue, Aug 11, 2026 at 11:47 AM Linus Walleij <linusw@kernel.org> wrote:

...

> > > > What if this is not good for all devices?
> > >
> > > At the moment, I couldn't find any device that the above rules would
> > > break. Certainly I could have missed something.
> >
> > No you're right, nothing breaks other than the that for one
> > instance of a driver the default/init semantics change.
> > Which isn't elegant IMO, but it works.
> >
> > > Definitely the things Michał wants to achieve can be done without
> > > changing the pinctrl core by using named pinctrl states and
> > > transitioning at the right times.
> >
> > I think we need to do that. This approach is a hack, it will be
> > hard for others to understand and lead to a lot of questions
> > about why this is done and so on. Better use a custom state.
> 
> Sure, that's a fair argument. To me, it felt like adding the extra
> state was more of a hack / working around the pinctrl limitations, but
> I can certainly see both perspectives.

FWIW, I'm also with Linus here, the fixing code and make exceptions smells like
a hack. Even having duplicating states with different names (mean semantics) is
much better approach.

...

> * At probe time, select "default" state since the port is closed.
> * At port open time, select "open" state if it exists.
> * If a port runtime suspends while open, select "idle" state if it exists.
> * If a port runtime resumes while open, try to select "open" if it
> exists, or fallback to "default".
> * If a port does system suspend while open, select "sleep" state if it exists.
> * If a port does system resume while open, try to select "open" if it
> exists, or fallback to "default".

> * If any kind of suspend/resume happens while a port is closed, it
> stays in "default"

Not sure about this one as it might be tricky for the case with OOB wake.
Yeah, it's questionable if we want wake source on never opened port
(kernel console?).

-- 
With Best Regards,
Andy Shevchenko


