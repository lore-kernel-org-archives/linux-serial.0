From: Aristeu Rozanski <aris@ruivo.org>
Subject: Re: Regarding Serial consloe
Date: Wed, 8 Oct 2008 10:32:28 -0400
Message-ID: <20081008143227.GU5387@cathedrallabs.org>
References: <241b8f7b0810072221s1c84a45cgb21443fd717d625d@mail.gmail.com> <241b8f7b0810072253l57f0fc0bm8356798972089b10@mail.gmail.com> <241b8f7b0810072256lb3611b3x49966d2d1782789b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lobo.ruivo.org ([66.92.68.119]:50713 "EHLO lobo.ruivo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753AbYJHOcr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Oct 2008 10:32:47 -0400
Content-Disposition: inline
In-Reply-To: <241b8f7b0810072256lb3611b3x49966d2d1782789b@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Prabhu Chawandi <prabhu.chavandi@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

>   I am using currnetly take the log messages on 8250 serial comsole...
> 
> I am usinf minicom for that ...
> 
> I got PL2303 device with me,  I am trying to route all  the debug
> messages to this USB - serial device .. I have tried modifying
> configurations ..
> i am not able to attain it,,
> 
> can anybody help me on this ...
do you have the PL2303 and USB host controller you're using compiled
built-in? also, you have to add console=ttyUSB0,<config options> as
kernel parameter.

-- 
Aristeu

