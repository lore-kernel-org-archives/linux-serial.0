From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: Plug and play for a tty line disciple networking device
Date: Wed, 20 Mar 2013 21:52:57 -0400
Message-ID: <CAKON4OyemnH1irinf3DHGUhHCuBuJfOKZ+8FkrGzAQVDCZ0Rjg@mail.gmail.com>
References: <CAKON4OxNV85-J8C-hodpq9pY5tRCT+7aYa=m4T3Vk04XSGhOrA@mail.gmail.com>
	<20130320232645.GC19779@kroah.com>
	<CAKON4Oz+2DfzeOcvmKgi3ADAtyC5ie5-22uUQdfH_gcqeaDSYA@mail.gmail.com>
	<20130321001424.GA27981@kroah.com>
	<CAKON4OyB6Tc_NSYjb9HRjpzZJOTEZowoYB8NeJwtO6T42wegBg@mail.gmail.com>
	<20130321003817.GA28389@kroah.com>
	<CAKON4OxceqF8LJa9L+QZ_jznFbD0VE+2PejdZWTpOC+gdU2vHg@mail.gmail.com>
	<20130321005604.GA28671@kroah.com>
	<CAKON4OzONj=mvaXrj+JdHBwA1ye422heHVu-nFaGdPiz1rHL9A@mail.gmail.com>
	<514A6039.50200@signal11.us>
	<CAKON4OxxY8cub9m9_u7Md_0AUvogJdSswvUD2j0X2KgvxOsjQw@mail.gmail.com>
	<514A6365.4010305@signal11.us>
	<CAKON4Ox+udgEMxQCohGX3z1CXJbL+Uk_xj3_vGsxybfmnTd7pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:37784 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab3CUBw7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Mar 2013 21:52:59 -0400
In-Reply-To: <CAKON4Ox+udgEMxQCohGX3z1CXJbL+Uk_xj3_vGsxybfmnTd7pw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

For an in-kernel solution serial-core would be to modified with a
create parameter that says don't make a user space device. Then when
the line discipline is registered on a hidden device make it
automatically active. FTDI driver USB ID array would get a parameter
for line discipline. If parameter is non-zero create the device in
hidden mode and set the line disciple.

Probably easier to just make new hardware with a real USB
implementation on the chip. Like the CC2531. But then I'd have to
program an 8051.

--
Jon Smirl
jonsmirl@gmail.com
