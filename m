From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: 16850 automatic RTS/CTS
Date: Wed, 8 May 2002 14:36:17 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0205081424330.2626-100000@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: tytso@mit.edu, linux-serial@vger.kernel.org

Hello

As of 2.5.6 there is some support in the serial driver for the 16850
automatic hardware handshake feature, in particular the automatic CTS is
enabled, but not the automatic RTS. Nor are the hysteresis levels set.
Why? I tried enabling all these features, it helps a good deal improving
the reliability of the data transfer, but still, at high baud-rates
(460800, 921600) and in the presence of user-space load data can be
overwritten in the driver's buffer. Why isn't this checked?

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany


