From: John Williams <john.williams@petalogix.com>
Subject: Re: [PATCH 57/57] microblaze_v7: Uartlite for Microblaze
Date: Wed, 25 Mar 2009 02:22:10 +1000
Message-ID: <1d3f23370903240922l38a8ce1ayb43ccdab52f89a21@mail.gmail.com>
References: <1237408284-8674-1-git-send-email-monstr@monstr.eu>
	 <d3f49195b8f675db48d2eda4f09fddb51af6f946.1237407249.git.monstr@monstr.eu>
	 <34c2f9e50610e147be556607e482b88fd674b887.1237407249.git.monstr@monstr.eu>
	 <15f6f10873f7c6f4f3b06f9d4d5af3ee9714f873.1237407249.git.monstr@monstr.eu>
	 <e5b88f50c39aa95431f5ecdb032c6676399ae198.1237407249.git.monstr@monstr.eu>
	 <50253611a0770c1ae6a63702208cfb9f96cd1f1a.1237407249.git.monstr@monstr.eu>
	 <28a81149bf51571cbc898a672efff4770fbc1efe.1237407249.git.monstr@monstr.eu>
	 <55868bc389e07d10d00e92a1da65f31256a26f4c.1237407249.git.monstr@monstr.eu>
	 <57d096a05c22f5b3dd1070e9ecd6e8e05b22e9b3.1237407249.git.monstr@monstr.eu>
	 <49C9046A.6060708@petalogix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qy0-f118.google.com ([209.85.221.118]:61072 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754424AbZCXQWN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Mar 2009 12:22:13 -0400
In-Reply-To: <49C9046A.6060708@petalogix.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: michal.simek@petalogix.com
Cc: monstr@monstr.eu, linux-kernel@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>, linux-serial@vger.kernel.org

On Wed, Mar 25, 2009 at 2:03 AM, Michal Simek
<michal.simek@petalogix.com> wrote:


>> =A0config SERIAL_OF_PLATFORM
>> =A0 =A0 =A0 tristate "Serial port on Open Firmware platform bus"
>> - =A0 =A0 depends on PPC_OF
>> + =A0 =A0 depends on PPC_OF || MICROBLAZE
>> =A0 =A0 =A0 depends on SERIAL_8250 || SERIAL_OF_PLATFORM_NWPSERIAL
>> =A0 =A0 =A0 help
>> =A0 =A0 =A0 =A0 If you have a PowerPC based system that has serial p=
orts

Trivial tweak - update the help text to "PowerPC or MicroBlaze"

John
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
