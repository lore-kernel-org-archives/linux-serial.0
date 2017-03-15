From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] serdev: Add minimal bus locking API
Date: Wed, 15 Mar 2017 09:25:41 -0500
Message-ID: <CAL_JsqJrpw2qoqxTjZfjf9_tETPDfGJ=kFMtnrNg9_0iqe0b5A@mail.gmail.com>
References: <20170314134819.19476-1-andrew.smirnov@gmail.com> <20170314134819.19476-3-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170314134819.19476-3-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>, Guenter Roeck <linux@roeck-us.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 14, 2017 at 8:48 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Add minimal bus locking API which is useful for serial devices that
> implement request-reply protocol

It's assumed that there's a single client, so I think the client
drivers should manage any locking they need. Maybe that changes if we
have multiple slave devices using RS-485.

Rob
