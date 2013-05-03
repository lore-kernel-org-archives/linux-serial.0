From: Stas Sergeev <stsp@list.ru>
Subject: Re: Regression: ftdi_sio is slow (since Wed Oct 10 15:05:06 2012)
Date: Fri, 03 May 2013 22:15:14 +0400
Message-ID: <5183FEB2.2090604@list.ru>
References: <5183D196.2080305@list.ru> <20130503163008.GA30699@kroah.com> <5183F62A.1020801@list.ru> <20130503165231.GA1966@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130503165231.GA1966@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jarkko Huijts <jarkko.huijts@gmail.com>, Alan Cox <alan@linux.intel.com>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Linux kernel <linux-kernel@vger.kernel.org>, Caylan Van Larson <i@caylan.net>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-serial@vger.kernel.org

03.05.2013 20:52, Greg KH =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> What exactly is the "problem" being seen?
OK, the problem is that while select() "stalls", the entire
output queue is transmitted, and when the app writes
more, there is already a big pause.
In fact, the app calls select() before writing every char,
so then the data transfer is very slow.
