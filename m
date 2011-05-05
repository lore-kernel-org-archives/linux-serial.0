From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC 1/5] platform-drivers-x86: add support for Technologic
 Systems TS-5xxx detection
Date: Thu, 5 May 2011 14:38:37 +0100
Message-ID: <20110505143837.7790edd5@lxorguk.ukuu.org.uk>
References: <1304115712-5299-1-git-send-email-vivien.didelot@savoirfairelinux.com>
	<1304115712-5299-2-git-send-email-vivien.didelot@savoirfairelinux.com>
	<20110430110705.5ca3376b@lxorguk.ukuu.org.uk>
	<1304520382-sup-3361@sfl>
	<20110504162954.7ecf5b5e@lxorguk.ukuu.org.uk>
	<1304537667-sup-2171@sfl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304537667-sup-2171@sfl>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jonas Fonseca <jonas.fonseca@savoirfairelinux.com>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>
List-Id: linux-serial@vger.kernel.org

> I've looked at that, and the board doesn't support DMI. Elements we have
> are the processor (i.e. AMD ElanSC520), the BIOS, maybe the memory and
> PCI bus layouts...

Well the CPU is a big help that cuts it down a lot. PCI bridge
subvendor/dev can be a good way to identify boards as well if they
manufacturers have actually bothered to set them properly.
