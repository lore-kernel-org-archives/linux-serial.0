Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983AC370D75;
	Wed,  6 May 2026 22:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778107350; cv=none; b=E9eUm44ua6Jq+r5tR4NP7QAkoB4MAOYStA731Dz8cOnydKAi74gaeLjhEhaoJ/5CTatMgduGiioZ4Kfz6k2zAuUOwaKfeElTUbGw/p0rWjh63xPgEnxccbMv4irwS1b6xq3z/xRjWRy/oQzpZsP0SkI/kxy4RIVE6wOF9B+LtiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778107350; c=relaxed/simple;
	bh=K/b5JlkplZquGEvTJp3gKlIadFD1bW/PIn35C6xs6iA=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ap95W4i32vGeh9nCJd21QXPEcUqwkNlr7YZ8NIn1k8rn1UnjWHnsPA0Ebb/Cg7y79evgPXIiof+ihpSh/TgG2WaEflLwJLdGPL/o3CGOS1PpOj+YFGvt5mpA1Ia96MC9DAr28fhMCmd53zvCuG1PxKI9b05iSuQIM83ucEJnUPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 0219692009E; Thu,  7 May 2026 00:42:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id F048292009D;
	Wed,  6 May 2026 23:42:18 +0100 (BST)
Date: Wed, 6 May 2026 23:42:18 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: linux-mips@vger.kernel.org, linux-serial@vger.kernel.org, 
    linux-serial@vger.kernel.org
Subject: [PATCH v3 00/10] MIPS: DEC: Fix serial device regressions + RTC
 cleanup
Message-ID: <alpine.DEB.2.21.2605062240290.46195@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

 This is v3 of the series, addressing a compilation warning discovered in 
the course of unrelated experimentation in 02/10 where a 64-bit->32-bit 
cast was directly made from a pointer to integer and missed owing to 
`-Wno-error' needed due to an unrelated issue, a fix for which has been 
posted already.  No change to code produced.

 In v2 fallout for 64-bit configurations has been fixed where the initial 
console output handler that uses calls into 32-bit firmware has to ensure 
no register input including the stack pointer is outside the 32-bit range, 
now that the handler is now also called from kernel threads other beyond 
the initial one.

 Two extra introductory changes, 01/10 and 02/10 have now been added to 
platform code.  No modification has been made to original changes.  The 
original description follows, updated for patch renumbering.

 Starting from commit 84a9582fd203 ("serial: core: Start managing serial 
controllers to enable runtime PM") drivers for serial devices used with 
the DEC platform have stopped working due to a null pointer dereference in 
the serial core, which means a kernel crash at bootstrap if the relevant 
driver has been enabled, as is usually the case for the system console.

 This patch series addresses the issue by switching the drivers away from 
legacy probing to using platform devices.  A notable consequence of this 
is the serial console is only switched from the bootconsole handler that 
uses firmware calls over to our serial driver at the time the driver is 
being properly brought up.  This causes messages to be produced to the 
console between the device reset and console setup, which in turn causes 
the firmware still being called via the bootconsole handler to loop 
forever owing to the transmitter having been disabled.

 Both drivers are affected and therefore introductory changes 04/10 and 
05/10 are included to fix the issue by doing a rudimentary device setup 
right after reset, using parameters compatible with those used by the 
firmware (9600n8).  There are auxiliary changes 03/10 and 06/10 included 
as well, that respectively prevent a message corruption regression from 
happening at reset due to the change in timing of messages produced to the 
console with the dz driver switch to the platform device, and simplify 
reset handling in the zs driver by issuing a channel rather hardware 
reset.  Then 07/10 and 08/10 actually switch the respective drivers to use 
platform devices.

 A tiny update follows, 09/10, that enables modular build for the dz 
driver, not to be backported as not a bug fix.

 Finally 10/10 is a small cleanup for the existing RTC device, included in 
the series and then last only, due to a mechanical dependency and neither 
for backporting, as it only addresses a code quality issue for a failure 
scenario that is not expected to trigger in reality.

 See individual change descriptions for details.  Verified with a 5000/200 
machine for the dz driver, and with 5000/150 and 5000/260 systems for the 
zs driver.

 Please apply.

 Previous iterations:

- v2 at: <https://lore.kernel.org/r/alpine.DEB.2.21.2604302336260.38805@angie.orcam.me.uk/>,

- v1 at: <https://lore.kernel.org/r/alpine.DEB.2.21.2604102250060.29980@angie.orcam.me.uk/>.

  Maciej
