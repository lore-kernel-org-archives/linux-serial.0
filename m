From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCHv2] serial: 8250: Add Quark X1000 to 8250 PCI driver
Date: Fri, 19 Sep 2014 14:02:18 +0100
Message-ID: <541C295A.6020101@nexus-software.ie>
References: <1411112629-3238-1-git-send-email-pure.logic@nexus-software.ie> <20140919105833.GB31784@xps8300> <541C14E7.8020208@nexus-software.ie> <1E478852902BF549B22CC4F16C2AE67C0F472359@PGSMSX108.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outbound-smtp05.blacknight.com ([81.17.249.38]:33092 "EHLO
	outbound-smtp05.blacknight.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755372AbaISNC0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Sep 2014 09:02:26 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
	by outbound-smtp05.blacknight.com (Postfix) with ESMTP id 60446210072
	for <linux-serial@vger.kernel.org>; Fri, 19 Sep 2014 13:00:39 +0000 (UTC)
In-Reply-To: <1E478852902BF549B22CC4F16C2AE67C0F472359@PGSMSX108.gar.corp.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Chew, Kean Ho" <kean.ho.chew@intel.com>, "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On 19/09/14 13:06, Chew, Kean Ho wrote:
>>> So we can take this now and when Kean Ho is ready he needs to
>>> basically revert it, or you could already introduce the new probe
>>> driver, 8250_quark.c, and Kean Ho can then add the DMA engine handling
>>> later to it.
>>>
>>> IMO we should add the 8250_quark.c already now.
>> Sounds great - is the 8250_quark.c code ready ?
>
> I'm still working on the DMA portion and requires more time.
> If the DMA section can be replaced by a placeholder, I should be good.

OK so.

Can you submit that soon, or should the simple PCI enabling code to be 
added ?


--
BOD

