From: "Prabhu Chawandi" <prabhu.chavandi@gmail.com>
Subject: Re: Regarding Serial consloe
Date: Fri, 10 Oct 2008 08:15:14 +0530
Message-ID: <241b8f7b0810091945w12725f3di4a8bab043d3a1bdc@mail.gmail.com>
References: <241b8f7b0810072221s1c84a45cgb21443fd717d625d@mail.gmail.com>
	 <241b8f7b0810072253l57f0fc0bm8356798972089b10@mail.gmail.com>
	 <241b8f7b0810072256lb3611b3x49966d2d1782789b@mail.gmail.com>
	 <20081008143227.GU5387@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:36166 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbYJJCpO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 9 Oct 2008 22:45:14 -0400
Received: by rv-out-0506.google.com with SMTP id k40so339343rvb.1
        for <linux-serial@vger.kernel.org>; Thu, 09 Oct 2008 19:45:14 -0700 (PDT)
In-Reply-To: <20081008143227.GU5387@cathedrallabs.org>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Aristeu Rozanski <aris@ruivo.org>
Cc: linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

Yeah...   I did all the configurations.

Still not getting the logs :(

I feel I am missing the part where USB- serial  will be registered to
the tty layer.

or Do I need to insert the code where we will be opening the device
and performimg the write/read  operations.

please comment on this ...


Thanks in advance
Prabhu

On 10/8/08, Aristeu Rozanski <aris@ruivo.org> wrote:
> >   I am using currnetly take the log messages on 8250 serial comsole...
> >
> > I am usinf minicom for that ...
> >
> > I got PL2303 device with me,  I am trying to route all  the debug
> > messages to this USB - serial device .. I have tried modifying
> > configurations ..
> > i am not able to attain it,,
> >
> > can anybody help me on this ...
> do you have the PL2303 and USB host controller you're using compiled
> built-in? also, you have to add console=ttyUSB0,<config options> as
> kernel parameter.
>
> --
> Aristeu
>
>
