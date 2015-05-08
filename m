From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: earlycon: no match?
Date: Fri, 8 May 2015 17:11:36 +0100 (BST)
Message-ID: <alpine.LFD.2.11.1505081708540.1538@eddie.linux-mips.org>
References: <20150503211054.GR15254@pengutronix.de> <55477BC1.6000805@hurleysoftware.com> <20150504194229.GR15254@pengutronix.de> <5547D4DB.8060300@hurleysoftware.com> <20150504205241.GT15254@pengutronix.de> <5547E447.9020604@hurleysoftware.com>
 <alpine.LFD.2.11.1505071749370.1538@eddie.linux-mips.org> <554B9F43.6000702@hurleysoftware.com> <alpine.LFD.2.11.1505071942110.1538@eddie.linux-mips.org> <554BD56D.9010800@hurleysoftware.com> <alpine.LFD.2.11.1505072241140.1538@eddie.linux-mips.org>
 <554BE936.2040508@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <554BE936.2040508@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Robert Schwebel <r.schwebel@pengutronix.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On Thu, 7 May 2015, Peter Hurley wrote:

> IOW, command line parameters of the form:
> 
> 	earlycon=uart8250,...
> 
> does not perform earlycon-to-console handoff.
[...]
> IOW, command line parameters of the form:
> 
> 	console=uart8250,...
> 
> performs earlycon-to-console handoff.

 OK, thanks.  I missed this detail previously and understood the two 
parameters had been since 2007 strict aliases to each other.  Thanks for 
your patience to explain it to me.

  Maciej
