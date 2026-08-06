Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE1340911F;
	Thu,  6 Aug 2026 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013656; cv=none; b=pu+R2QmsR165Ut1UVVW7zAutjBmnAW5Xaj3wpD/rdDO4aYxvhcoztlx7zqc+X2San5E3zaY24ZMvTv8dyk5F4Ia9xWLrTt/7A3sLZ9gfFHwoFXsJWwCjtxpRWzTjqqWfgJzpNTT9BHDvTbBMYDEqR+U7bSZOOQG1igw7dVbsxvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013656; c=relaxed/simple;
	bh=qbEifO6N5SSFlhshimiDm0YNmcFPF+Gea4+us/7hqXI=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=V0bC8B1h5Cd5l2LhReokM68RClCOpMm2YcdeCX0OlTM+K0nWHLjjFLWnWZqjGv2HIytM/E5Rc+jmzIWkCCR9f+U6PR2HY5yb61fwteuPrN2zVoQUStN3y7+ydvTx8uFxEfhLA6lCWyX/EK1VObGbtlCXupVBsOe1kpuiS5jj6No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 3723692009C; Thu,  6 Aug 2026 12:54:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 2FDE292009B;
	Thu,  6 Aug 2026 11:54:06 +0100 (BST)
Date: Thu, 6 Aug 2026 11:54:06 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: linux-mips@vger.kernel.org, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] MIPS: SiByte: Fix serial device regressions
Message-ID: <alpine.DEB.2.21.2608060322360.55540@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

 In this v3 of the series compared to v2 changes 3/6 through 6/6 have been 
dropped as not meant for backporting, along with the relevant submission 
cc recipients.  Additionally the delay loop introduced with 1/6 has been 
fixed to work correctly early in boot.  The relevant parts of the original 
cover letter follow.

 Starting from commit 84a9582fd203 ("serial: core: Start managing serial 
controllers to enable runtime PM") the driver for the SiByte onchip DUART 
has stopped working due to a null pointer dereference in the serial core, 
which means a kernel crash at bootstrap if the driver has been enabled, as 
is usually the case for the system console.

 This patch series addresses the issue by switching the driver away from 
legacy probing to using platform devices.  A notable consequence of this 
is the serial console is only switched from the bootconsole handler that 
uses firmware calls over to our serial driver at the time the driver is 
being properly brought up.  This causes messages to be produced to the 
console between the device reset and console setup, which in turn causes 
the firmware still being called via the bootconsole handler to loop 
forever owing to the transmitter having been disabled.

 Therefore introductory change 2/3 is included to fix the issue by doing a 
rudimentary device setup right after reset, using parameters compatible 
with those used by the firmware (115200n8).  There is auxiliary change 1/3 
included as well that prevents message corruption from happening at reset, 
which becomes more prominent due to the change in timing, with the driver 
switch to the platform device, of messages produced to the console.

 See individual change descriptions for details.  Verified with a SWARM
(BCM91250A) system.

 Please apply.

 Previous iterations:

- v2 at: <https://lore.kernel.org/r/alpine.DEB.2.21.2605241602220.1450@angie.orcam.me.uk/>.

- v1 at: <https://lore.kernel.org/r/alpine.DEB.2.21.2604130239560.29980@angie.orcam.me.uk/>.

  Maciej
