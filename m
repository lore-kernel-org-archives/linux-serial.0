From: "Prabhu Chawandi" <prabhu.chavandi@gmail.com>
Subject: Re: Regarding Serial consloe
Date: Fri, 10 Oct 2008 15:28:56 +0530
Message-ID: <241b8f7b0810100258u4a393c96s21d491d62a05e50c@mail.gmail.com>
References: <241b8f7b0810072221s1c84a45cgb21443fd717d625d@mail.gmail.com>
	 <241b8f7b0810072253l57f0fc0bm8356798972089b10@mail.gmail.com>
	 <241b8f7b0810072256lb3611b3x49966d2d1782789b@mail.gmail.com>
	 <20081008143227.GU5387@cathedrallabs.org>
	 <241b8f7b0810091945w12725f3di4a8bab043d3a1bdc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:40632 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbYJJJ65 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Oct 2008 05:58:57 -0400
Received: by wa-out-1112.google.com with SMTP id v27so221768wah.21
        for <linux-serial@vger.kernel.org>; Fri, 10 Oct 2008 02:58:56 -0700 (PDT)
In-Reply-To: <241b8f7b0810091945w12725f3di4a8bab043d3a1bdc@mail.gmail.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Aristeu Rozanski <aris@ruivo.org>
Cc: linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

Hi,

Please update me on this....

it will be a greate help ....


Thanks in advance
Prabhu

On 10/10/08, Prabhu Chawandi <prabhu.chavandi@gmail.com> wrote:
> Yeah...   I did all the configurations.
>
> Still not getting the logs :(
>
> I feel I am missing the part where USB- serial  will be registered to
> the tty layer.
>
> or Do I need to insert the code where we will be opening the device
> and performimg the write/read  operations.
>
> please comment on this ...
>
>
> Thanks in advance
> Prabhu
>
> On 10/8/08, Aristeu Rozanski <aris@ruivo.org> wrote:
> > >   I am using currnetly take the log messages on 8250 serial comsole...
> > >
> > > I am usinf minicom for that ...
> > >
> > > I got PL2303 device with me,  I am trying to route all  the debug
> > > messages to this USB - serial device .. I have tried modifying
> > > configurations ..
> > > i am not able to attain it,,
> > >
> > > can anybody help me on this ...
> > do you have the PL2303 and USB host controller you're using compiled
> > built-in? also, you have to add console=ttyUSB0,<config options> as
> > kernel parameter.
> >
> > --
> > Aristeu
> >
> >
>
