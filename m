From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2] tty/serial: Add a serial port simulator
Date: Thu, 28 Mar 2019 12:39:12 -0700
Message-ID: <447407be-0f49-f29d-6e81-bf4ed0a6e56b@zytor.com>
References: <20190305171231.22133-1-minyard@acm.org>
 <eea0ad95-8344-371a-1dd0-58c8366a355b@infradead.org>
 <20190306015149.GD4290@minyard.net>
 <041e137e-0b9d-04f9-255d-b1f402b23c17@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <041e137e-0b9d-04f9-255d-b1f402b23c17@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, cminyard@mvista.com
Cc: minyard@acm.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Dumb question: this is basically a pty on steroids. Wouldn't this be
better done by enhancing the pty devices?

	-0hpa
