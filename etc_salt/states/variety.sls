variety-setup:
  cmd.run:
    - name: bzr branch lp:variety
    - cwd: /home/pi
    - require:
      - sls: dependencies
  file.managed:
	  - name: /home/pi/.config/variety/variety.conf
	  - source: salt://variety/variety.conf

variety-run
  file.managed:
	  - name: /etc/supervisor/conf.d/variety.conf
	  - source: salt://variety/supervisor.conf
  supervisord.running:
    - name: variety
    - require:
      - variety-setup
